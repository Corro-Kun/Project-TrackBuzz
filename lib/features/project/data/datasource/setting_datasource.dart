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

  Future<int> getStateProject(int id) async {
    final db = await DataBase().OpenDB();

    final data = await db.query('project', where: 'id = ?', whereArgs: [id]);

    final result = data[0]['state'] as int;

    return result;
  }

  Future<dynamic> updateSetting(Map<String, dynamic> value, int state) async {
    final db = await DataBase().OpenDB();
    await db.update(
      'project_settings',
      {
        'bill': value['bill'],
        'description': value['description'],
        'price': value['price'],
        'coin': value['coin'],
      },
      where: 'id = ?',
      whereArgs: [value['id']],
    );
    await db.update(
      'project',
      {'state': state},
      where: 'id = ?',
      whereArgs: [value['id']],
    );
  }
}
