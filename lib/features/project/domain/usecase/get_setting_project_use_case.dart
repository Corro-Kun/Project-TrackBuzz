import 'package:trackbuzz/features/project/data/models/setting_model.dart';
import 'package:trackbuzz/features/project/data/services/setting_service.dart';

class GetSettingProjectUseCase {
  final SettingService service;

  GetSettingProjectUseCase(this.service);

  Future<SettingModel> execute(int id) async {
    return await service.getSetting(id);
  }
}
