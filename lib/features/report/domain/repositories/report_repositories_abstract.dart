import 'package:trackbuzz/features/report/data/models/report_model.dart';
import 'package:trackbuzz/features/report/data/models/total_report_model.dart';

abstract class ReportRepositoriesAbstract {
  Future<List<TotalReportModel>> getTotal();
  Future<List<ReportModel>> getReport();
}
