import 'package:trackbuzz/features/track/data/models/record_model.dart';
import 'package:trackbuzz/features/track/data/services/chronometer_service.dart';

class GetCurrentRecordUseCase {
  final ChronometerService service;

  GetCurrentRecordUseCase(this.service);

  Future<List<RecordModel>> execute() async {
    return await service.getCurrentRecord();
  }
}
