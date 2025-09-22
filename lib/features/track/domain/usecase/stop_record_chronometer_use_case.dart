import 'package:trackbuzz/features/track/data/services/chronometer_service.dart';

class StopRecordChronometerUseCase {
  final ChronometerService service;

  StopRecordChronometerUseCase(this.service);

  Future<dynamic> execute(
    int id,
    String finish,
    String start,
    int idProject,
  ) async {
    return await service.stopRecord(id, finish, start, idProject);
  }
}
