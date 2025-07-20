import 'package:sqflite/sqlite_api.dart';
import 'package:trackbuzz/core/database/data_base.dart';

class ProjectDatasource {
  Future<List<Map<String, dynamic>>> getProjects() async {
    final db = await DataBase().OpenDB();

    return await db.query('project');
  }

  Future<Map<String, dynamic>> getProject(int id) async {
    final db = await DataBase().OpenDB();

    final data = await db.query('project', where: 'id = ?', whereArgs: [id]);

    return data[0];
  }

  Future<dynamic> CreateProject(String title, String path) async {
    final db = await DataBase().OpenDB();

    int id = await db.insert('project', {
      'title': title,
      'image': path,
    }, conflictAlgorithm: ConflictAlgorithm.replace);

    await db.insert('project_settings', {
      'id_project': id,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<dynamic> updateProject(int id, String title, String path) async {
    final db = await DataBase().OpenDB();

    await db.update(
      'project',
      {'title': title, 'path': path},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
