import 'package:trackbuzz/features/track/data/datasource/chronometer_datasource.dart';
import 'package:trackbuzz/features/track/data/models/record_model.dart';
import 'package:trackbuzz/features/track/domain/repositories/chronometer_repositories_abstract.dart';

class ChronometerRepository extends ChronometerRepositoriesAbstract {
  final ChronometerDatasource datasource;

  ChronometerRepository(this.datasource);

  @override
  Future<List<RecordModel>> getCurrentRecord() async {
    final data = await datasource.getCurrentRecord();
    return List.generate(data.length, (i) {
      return RecordModel.fromJson(data[i]);
    });
  }

  @override
  Future<dynamic> startRecord(String start, int idProject, int? idTask) async {
    return await datasource.startRecord(start, idProject, idTask);
  }

  @override
  Future stopRecord(int id, String finish, String start, int idProject) async {
    return await datasource.stopRecord(id, finish, start, idProject);
  }
}
