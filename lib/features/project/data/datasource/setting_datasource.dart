import 'package:trackbuzz/core/database/data_base.dart';

class SettingDatasource {
  Future<Map<String, dynamic>> getSetting(int id) async {
    final db = await DataBase().OpenDB();

    final data = await db.query(
      'project_settings',
      where: 'id_project = ?',
      whereArgs: [id],
    );

    return data[0];
  }
}
