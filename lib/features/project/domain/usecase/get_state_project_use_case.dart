import 'package:trackbuzz/features/project/data/services/setting_service.dart';

class GetStateProjectUseCase {
  final SettingService service;

  GetStateProjectUseCase(this.service);

  Future<int> execute(int id) async {
    return await service.getStateProject(id);
  }
}
