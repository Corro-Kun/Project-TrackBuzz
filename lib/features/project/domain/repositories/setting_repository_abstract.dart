import 'package:trackbuzz/features/project/data/models/setting_model.dart';

abstract class SettingRepositoryAbstract {
  Future<SettingModel> getSetting(int id);
}
