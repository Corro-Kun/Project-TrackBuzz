import 'package:sqflite/sqlite_api.dart';
import 'package:trackbuzz/core/database/data_base.dart';

class ProjectDatasource {
  Future<List<Map<String, dynamic>>> getProjects() async {
    final db = await DataBase().OpenDB();

    return await db.rawQuery("""
        SELECT p.*, t.second, t.activity
        FROM project p
        JOIN total t ON t.id_project = p.id
      """);
  }

  Future<Map<String, dynamic>> getProject(int id) async {
    final db = await DataBase().OpenDB();

    final data = await db.rawQuery(
      """
        SELECT p.*, t.second, t.activity
        FROM project p
        JOIN total t ON t.id_project = p.id
        WHERE p.id = ?
      """,
      [id],
    );

    return data[0];
  }

  Future<dynamic> createProject(
    String title,
    String? description,
    String path,
  ) async {
    final db = await DataBase().OpenDB();

    int id = await db.insert('project', {
      'title': title,
      'description': description,
      'image': path,
    }, conflictAlgorithm: ConflictAlgorithm.replace);

    await db.insert('project_settings', {
      'id_project': id,
    }, conflictAlgorithm: ConflictAlgorithm.replace);

    await db.insert('total', {
      'second': 0,
      'activity': 0,
      'id_project': id,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<dynamic> updateProject(
    int id,
    String title,
    String? description,
    String path,
  ) async {
    final db = await DataBase().OpenDB();

    await db.update(
      'project',
      {'title': title, 'description': description, 'image': path},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<dynamic> deleteProject(int id) async {
    final db = await DataBase().OpenDB();

    await db.delete('record', where: 'id_project = ?', whereArgs: [id]);
    await db.delete('task', where: 'id_project = ?', whereArgs: [id]);
    await db.delete(
      'project_settings',
      where: 'id_project = ?',
      whereArgs: [id],
    );
    await db.delete('total', where: 'id_project = ?', whereArgs: [id]);
    await db.delete('project', where: 'id = ?', whereArgs: [id]);
  }
}
