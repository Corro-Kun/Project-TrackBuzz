import 'package:bloc/bloc.dart';
import 'package:trackbuzz/features/report/domain/usecase/get_report_use_case.dart';
import 'package:trackbuzz/features/report/presentation/bloc/report/report_event.dart';
import 'package:trackbuzz/features/report/presentation/bloc/report/report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final GetReportUseCase getReportUseCase;

  ReportBloc({required this.getReportUseCase}) : super(ReportInitial()) {
    on<GetReports>(_onGetReports);
  }

  Future<void> _onGetReports(
    GetReports event,
    Emitter<ReportState> emit,
  ) async {
    emit(ReportLoading());
    try {
      int seconds = 0;
      final reports = await getReportUseCase.execute();
      for (var i = 0; i < reports.length; i++) {
        final finishSaved = DateTime.parse(reports[i].finish);
        seconds += finishSaved
            .difference(DateTime.parse(reports[i].start))
            .inSeconds;
      }
      emit(ReportLoaded(reports: reports, seconds: seconds));
    } catch (e) {
      emit(ReportError(message: e.toString()));
    }
  }
}
