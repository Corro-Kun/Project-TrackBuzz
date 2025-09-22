import 'package:trackbuzz/features/track/data/models/record_model.dart';
import 'package:trackbuzz/features/track/domain/repositories/chronometer_repositories_abstract.dart';

class ChronometerService {
  final ChronometerRepositoriesAbstract repository;

  ChronometerService(this.repository);

  Future<List<RecordModel>> getCurrentRecord() async {
    return await repository.getCurrentRecord();
  }

  Future<dynamic> startRecord(String start, int idProject, int? idTask) async {
    return await repository.startRecord(start, idProject, idTask);
  }

  Future<dynamic> stopRecord(
    int id,
    String finish,
    String start,
    int idProject,
  ) async {
    return await repository.stopRecord(id, finish, start, idProject);
  }
}
