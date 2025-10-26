import 'package:trackbuzz/features/project/domain/repositories/record_repository_abstract.dart';
import 'package:trackbuzz/features/track/data/models/record_model.dart';

class RecordService {
  final RecordRepositoryAbstract repository;

  RecordService(this.repository);

  Future<List<RecordModel>> getRecord(int id, int page) async {
    return await repository.getProject(id, page);
  }

  Future<List<RecordModel>> getRecordWithTask(int id) async {
    return await repository.getProjectWithTask(id);
  }

  Future<int> getSeconds(int id) async {
    return await repository.getSeconds(id);
  }
}
