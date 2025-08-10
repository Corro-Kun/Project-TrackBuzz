import 'package:trackbuzz/features/report/data/models/report_model.dart';

abstract class ReportRepositoriesAbstract {
  Future<List<ReportModel>> getReport();
}
