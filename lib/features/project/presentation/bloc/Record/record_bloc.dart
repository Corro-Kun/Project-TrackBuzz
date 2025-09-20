import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackbuzz/features/project/domain/usecase/get_record_of_project_use_case.dart';
import 'package:trackbuzz/features/project/domain/usecase/get_seconds_use_case.dart';
import 'package:trackbuzz/features/project/presentation/bloc/Record/record_event.dart';
import 'package:trackbuzz/features/project/presentation/bloc/Record/record_state.dart';

class RecordBloc extends Bloc<RecordEvent, RecordState> {
  final GetRecordOfProjectUseCase getRecordOfProjectUseCase;
  final GetSecondsUseCase getSecondsUseCase;

  RecordBloc({
    required this.getRecordOfProjectUseCase,
    required this.getSecondsUseCase,
  }) : super(RecordInitial()) {
    on<GetRecord>(_onGetRecord);
  }

  Future<void> _onGetRecord(GetRecord event, Emitter<RecordState> emit) async {
    emit(RecordLoading());
    try {
      final records = await getRecordOfProjectUseCase.execute(event.id);
      //final seconds = await getSecondsUseCase.execute(event.id);
      int seconds = 0;
      for (var i = 0; i < records.length; i++) {
        final finishSaved = DateTime.parse(records[i].finish ?? '');
        seconds += finishSaved
            .difference(DateTime.parse(records[i].start))
            .inSeconds;
      }
      emit(RecordLoaded(records: records, seconds: seconds));
    } catch (e) {
      emit(RecordError(message: e.toString()));
    }
  }
}
