import 'package:trackbuzz/features/track/data/services/chronometer_service.dart';

class StartRecordChronometerUseCase {
  final ChronometerService service;

  StartRecordChronometerUseCase(this.service);

  Future<dynamic> execute(String start, int idProject) async {
    return await service.startRecord(start, idProject);
  }
}
