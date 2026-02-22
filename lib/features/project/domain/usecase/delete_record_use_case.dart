import 'package:trackbuzz/features/project/data/services/record_service.dart';

class DeleteRecordUseCase {
  final RecordService service;

  DeleteRecordUseCase(this.service);

  Future<dynamic> execute(int id, int idProject) async {
    return await service.deleteRecord(id, idProject);
  }
}
