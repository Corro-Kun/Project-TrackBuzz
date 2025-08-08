import 'package:sqflite/sqflite.dart';
import 'package:trackbuzz/core/database/data_base.dart';

class ChronometerDatasource {
  Future<List<Map<String, dynamic>>> getCurrentRecord() async {
    final db = await DataBase().OpenDB();

    final data = await db.query('record', where: 'active = ?', whereArgs: [1]);

    return data;
  }

  Future<dynamic> startRecord(String start, int idProject) async {
    final db = await DataBase().OpenDB();

    await db.insert('record', {
      'start': start,
      'id_project': idProject,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<dynamic> stopRecord(int id, String finish) async {
    final db = await DataBase().OpenDB();

    await db.update(
      'record',
      {'finish': finish, 'active': 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
