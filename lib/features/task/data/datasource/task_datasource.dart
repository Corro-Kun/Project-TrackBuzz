import 'package:trackbuzz/core/database/data_base.dart';

class TaskDatasource {
  Future<List<Map<String, dynamic>>> getTasks(int id) async {
    final db = await DataBase().OpenDB();

    return await db.query('task', where: 'id_project = ?', whereArgs: [id]);
  }

  Future<dynamic> createTask(String name, String description, int id) async {
    final db = await DataBase().OpenDB();

    await db.insert('task', {
      'name': name,
      'description': description,
      'id_project': id,
    });
  }
}
