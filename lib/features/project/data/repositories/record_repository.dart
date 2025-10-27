import 'package:trackbuzz/features/project/data/datasource/record_datasource.dart';
import 'package:trackbuzz/features/project/domain/repositories/record_repository_abstract.dart';
import 'package:trackbuzz/features/track/data/models/record_model.dart';

class RecordRepository extends RecordRepositoryAbstract {
  final RecordDatasource datasource;

  RecordRepository(this.datasource);

  @override
  Future<List<RecordModel>> getProject(int id, int page) async {
    final data = await datasource.getRecord(id, page);
    return List.generate(data.length, (i) {
      return RecordModel.fromJson(data[i]);
    });
  }

  @override
  Future<List<RecordModel>> getRecordWithoutPage(int id) async {
    final data = await datasource.getRecordWithoutPage(id);
    return List.generate(data.length, (i) {
      return RecordModel.fromJson(data[i]);
    });
  }

  @override
  Future<List<RecordModel>> getProjectWithTask(int id) async {
    final data = await datasource.getRecordWithTask(id);
    return List.generate(data.length, (i) {
      return RecordModel.fromJson(data[i]);
    });
  }

  @override
  Future<int> getSeconds(int id) async {
    return await datasource.getSeconds(id);
  }
}
