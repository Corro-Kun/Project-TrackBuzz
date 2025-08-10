import 'package:trackbuzz/features/report/data/models/report_model.dart';
import 'package:trackbuzz/features/report/domain/repositories/report_repositories_abstract.dart';

class ReportServices {
  final ReportRepositoriesAbstract repository;

  ReportServices(this.repository);

  Future<List<ReportModel>> getReport() async {
    return await repository.getReport();
  }
}
