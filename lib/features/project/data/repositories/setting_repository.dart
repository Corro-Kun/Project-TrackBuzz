import 'package:trackbuzz/features/project/data/datasource/setting_datasource.dart';
import 'package:trackbuzz/features/project/data/models/setting_model.dart';
import 'package:trackbuzz/features/project/domain/repositories/setting_repository_abstract.dart';

class SettingRepository extends SettingRepositoryAbstract {
  final SettingDatasource datasource;

  SettingRepository(this.datasource);

  @override
  Future<SettingModel> getSetting(int id) async {
    final data = await datasource.getSetting(id);

    return SettingModel.fromJson(data);
  }
}
