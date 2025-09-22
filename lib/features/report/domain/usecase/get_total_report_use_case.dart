import 'package:trackbuzz/features/report/data/models/total_report_model.dart';
import 'package:trackbuzz/features/report/data/services/report_services.dart';

class GetTotalReportUseCase {
  final ReportServices services;

  GetTotalReportUseCase(this.services);

  Future<List<TotalReportModel>> execute() async {
    return await services.getTotal();
  }
}
