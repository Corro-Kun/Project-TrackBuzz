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

  Future<dynamic> updateSetting(Map<String, dynamic> value) async {
    final db = await DataBase().OpenDB();
    await db.update(
      'project_settings',
      {'bill': value['bill'], 'price': value['price'], 'coin': value['coin']},
      where: 'id = ?',
      whereArgs: [value['id']],
    );
  }
}
