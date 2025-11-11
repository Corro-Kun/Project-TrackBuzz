import 'package:trackbuzz/features/project/data/models/setting_model.dart';

abstract class SettingRepositoryAbstract {
  Future<SettingModel> getSetting(int id);
  Future<int> getStateProject(int id);
  Future<dynamic> updateSetting(SettingModel setting);
}
