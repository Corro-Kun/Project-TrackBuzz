import 'package:trackbuzz/features/project/data/services/record_service.dart';
import 'package:trackbuzz/features/track/data/models/record_model.dart';

class GetRecordOfProjectUseCase {
  final RecordService service;

  GetRecordOfProjectUseCase(this.service);

  Future<List<RecordModel>> execute(int id) async {
    return await service.getRecord(id);
  }
}
