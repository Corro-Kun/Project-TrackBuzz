import 'package:trackbuzz/features/project/data/models/setting_model.dart';
import 'package:trackbuzz/features/project/data/services/setting_service.dart';

class UpdateSettingUseCase {
  final SettingService service;

  UpdateSettingUseCase(this.service);

  Future<dynamic> execute(SettingModel setting) async {
    await service.updateSetting(setting);
  }
}
