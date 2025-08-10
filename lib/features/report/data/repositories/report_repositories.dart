import 'package:trackbuzz/features/report/data/datasource/report_datasource.dart';
import 'package:trackbuzz/features/report/data/models/report_model.dart';
import 'package:trackbuzz/features/report/domain/repositories/report_repositories_abstract.dart';

class ReportRepositories extends ReportRepositoriesAbstract {
  final ReportDatasource datasource;

  ReportRepositories(this.datasource);

  @override
  Future<List<ReportModel>> getReport() async {
    final data = await datasource.getReport();
    return List.generate(data.length, (i) {
      return ReportModel.fromJson(data[i]);
    });
  }
}
