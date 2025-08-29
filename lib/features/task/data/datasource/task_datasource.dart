import 'package:trackbuzz/core/database/data_base.dart';

class TaskDatasource {
  Future<List<Map<String, dynamic>>> getTasks(int id) async {
    final db = await DataBase().OpenDB();

    return await db.query('task', where: 'id_project = ?', whereArgs: [id]);
  }

  Future<Map<String, dynamic>> getTask(int id) async {
    final db = await DataBase().OpenDB();

    final data = await db.query('task', where: 'id = ?', whereArgs: [id]);

    return data[0];
  }

  Future<dynamic> createTask(String name, String description, int id) async {
    final db = await DataBase().OpenDB();

    await db.insert('task', {
      'name': name,
      'description': description,
      'id_project': id,
    });
  }

  Future<dynamic> updateTask(String name, String description, int id) async {
    final db = await DataBase().OpenDB();

    await db.update(
      'task',
      {'name': name, 'description': description},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<dynamic> deleteTask(int id) async {
    final db = await DataBase().OpenDB();

    await db.update(
      'record',
      {'id_task': null},
      where: 'id_task = ?',
      whereArgs: [id],
    );

    await db.delete('task', where: 'id = ?', whereArgs: [id]);
  }
}
