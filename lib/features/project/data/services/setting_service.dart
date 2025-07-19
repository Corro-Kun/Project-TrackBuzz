import 'package:trackbuzz/features/project/data/models/setting_model.dart';
import 'package:trackbuzz/features/project/domain/repositories/setting_repository_abstract.dart';

class SettingService {
  final SettingRepositoryAbstract repository;

  SettingService(this.repository);

  Future<SettingModel> getSetting(int id) async {
    return await repository.getSetting(id);
  }

  Future<dynamic> updateSetting(SettingModel setting) async {
    await repository.updateSetting(setting);
  }
}
