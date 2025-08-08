import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackbuzz/features/track/domain/usecase/get_current_record_use_case.dart';
import 'package:trackbuzz/features/track/domain/usecase/start_record_chronometer_use_case.dart';
import 'package:trackbuzz/features/track/domain/usecase/stop_record_chronometer_use_case.dart';
import 'package:trackbuzz/features/track/presentation/bloc/chronometer/chronometer_event.dart';
import 'package:trackbuzz/features/track/presentation/bloc/chronometer/chronometer_state.dart';

class ChronometerBloc extends Bloc<ChronometerEvent, ChronometerState> {
  final GetCurrentRecordUseCase getCurrentRecordUseCase;
  final StartRecordChronometerUseCase startRecordChronometerUseCase;
  final StopRecordChronometerUseCase stopRecordChronometerUseCase;

  ChronometerBloc({
    required this.getCurrentRecordUseCase,
    required this.startRecordChronometerUseCase,
    required this.stopRecordChronometerUseCase,
  }) : super(ChronometerInitial()) {
    on<GetCurrent>(_onGetCurrent);
    on<StartRecord>(_onStartRecord);
    on<StopRecord>(_onStopRecord);
  }

  Future<void> _onGetCurrent(
    GetCurrent event,
    Emitter<ChronometerState> emit,
  ) async {
    emit(ChronometerInitial());
    try {
      final record = await getCurrentRecordUseCase.execute();
      emit(ChronometerLoaded(record: record.isNotEmpty ? record[0] : null));
    } catch (e) {
      emit(ChronometerError(message: e.toString()));
    }
  }

  Future<void> _onStartRecord(
    StartRecord event,
    Emitter<ChronometerState> emit,
  ) async {
    try {
      await startRecordChronometerUseCase.execute(event.start, event.id);
      final record = await getCurrentRecordUseCase.execute();
      emit(ChronometerLoaded(record: record.isNotEmpty ? record[0] : null));
    } catch (e) {
      emit(ChronometerError(message: e.toString()));
    }
  }

  Future<void> _onStopRecord(
    StopRecord event,
    Emitter<ChronometerState> emit,
  ) async {
    try {
      await stopRecordChronometerUseCase.execute(event.id, event.finish);
      emit(ChronometerLoaded(record: null));
    } catch (e) {
      emit(ChronometerError(message: e.toString()));
    }
  }
}
