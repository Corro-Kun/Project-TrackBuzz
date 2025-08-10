import 'package:trackbuzz/features/report/data/models/report_model.dart';
import 'package:trackbuzz/features/report/data/services/report_services.dart';

class GetReportUseCase {
  final ReportServices services;

  GetReportUseCase(this.services);

  Future<List<ReportModel>> execute() async {
    return await services.getReport();
  }
}
