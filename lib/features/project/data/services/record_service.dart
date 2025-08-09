import 'package:trackbuzz/features/project/domain/repositories/record_repository_abstract.dart';
import 'package:trackbuzz/features/track/data/models/record_model.dart';

class RecordService {
  final RecordRepositoryAbstract repository;

  RecordService(this.repository);

  Future<List<RecordModel>> getRecord(int id) async {
    return await repository.getProject(id);
  }
}
