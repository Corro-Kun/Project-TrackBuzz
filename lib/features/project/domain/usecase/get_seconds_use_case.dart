import 'package:trackbuzz/features/project/data/services/record_service.dart';

class GetSecondsUseCase {
  final RecordService service;

  GetSecondsUseCase(this.service);

  Future<int> execute(int id) async {
    return await service.getSeconds(id);
  }
}
