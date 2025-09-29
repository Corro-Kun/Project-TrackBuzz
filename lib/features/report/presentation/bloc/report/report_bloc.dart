import 'package:bloc/bloc.dart';
import 'package:trackbuzz/features/report/domain/usecase/get_report_use_case.dart';
import 'package:trackbuzz/features/report/domain/usecase/get_total_report_use_case.dart';
import 'package:trackbuzz/features/report/presentation/bloc/report/report_event.dart';
import 'package:trackbuzz/features/report/presentation/bloc/report/report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final GetReportUseCase getReportUseCase;
  final GetTotalReportUseCase getTotalReportUseCase;

  ReportBloc({
    required this.getReportUseCase,
    required this.getTotalReportUseCase,
  }) : super(ReportInitial()) {
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
      final total = await getTotalReportUseCase.execute();
      for (var i = 0; i < total.length; i++) {
        seconds += total[i].second;
      }
      emit(ReportLoaded(reports: reports, totals: total, seconds: seconds));
    } catch (e) {
      emit(ReportError(message: e.toString()));
    }
  }
}
