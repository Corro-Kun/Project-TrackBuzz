import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackbuzz/features/project/domain/usecase/get_activity_use_case.dart';
import 'package:trackbuzz/features/project/domain/usecase/get_record_of_project_use_case.dart';
import 'package:trackbuzz/features/project/domain/usecase/get_record_with_task_use_case.dart';
import 'package:trackbuzz/features/project/domain/usecase/get_seconds_use_case.dart';
import 'package:trackbuzz/features/project/presentation/bloc/Record/record_event.dart';
import 'package:trackbuzz/features/project/presentation/bloc/Record/record_state.dart';

class RecordBloc extends Bloc<RecordEvent, RecordState> {
  final GetRecordOfProjectUseCase getRecordOfProjectUseCase;
  final GetSecondsUseCase getSecondsUseCase;
  final GetActivityUseCase getActivityUseCase;
  final GetRecordWithTaskUseCase getRecordWithTaskUseCase;

  RecordBloc({
    required this.getRecordOfProjectUseCase,
    required this.getSecondsUseCase,
    required this.getActivityUseCase,
    required this.getRecordWithTaskUseCase,
  }) : super(RecordInitial()) {
    on<GetRecord>(_onGetRecord);
    on<GetRecordByPage>(_onGetRecordByPage);
  }

  Future<void> _onGetRecord(GetRecord event, Emitter<RecordState> emit) async {
    emit(RecordLoading());
    try {
      final records = await getRecordOfProjectUseCase.execute(event.id, 0);
      final activity = await getActivityUseCase.execute(event.id);
      final recordTasks = await getRecordWithTaskUseCase.execute(event.id);
      //print('normal: ${records.length}, new: ${recordTasks.length}');
      emit(
        RecordLoaded(
          records: records,
          activity: activity,
          recordTasks: recordTasks,
          page: 0,
        ),
      );
    } catch (e) {
      emit(RecordError(message: e.toString()));
    }
  }

  Future<void> _onGetRecordByPage(
    GetRecordByPage event,
    Emitter<RecordState> emit,
  ) async {
    final currentState = state as RecordLoaded;
    try {
      final records = await getRecordOfProjectUseCase.execute(
        event.id,
        currentState.page + 1,
      );
      emit(
        RecordLoaded(
          records: [...currentState.records, ...records],
          activity: currentState.activity,
          recordTasks: currentState.recordTasks,
          page: currentState.page + 1,
        ),
      );
    } catch (e) {
      emit(RecordError(message: e.toString()));
    }
  }
}
