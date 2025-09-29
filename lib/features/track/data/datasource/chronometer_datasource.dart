import 'package:sqflite/sqflite.dart';
import 'package:trackbuzz/core/database/data_base.dart';

class ChronometerDatasource {
  Future<List<Map<String, dynamic>>> getCurrentRecord() async {
    final db = await DataBase().OpenDB();

    final data = await db.query('record', where: 'active = ?', whereArgs: [1]);

    return data;
  }

  Future<dynamic> startRecord(String start, int idProject, int? idTask) async {
    final db = await DataBase().OpenDB();

    await db.insert('record', {
      'start': start,
      'id_project': idProject,
      'id_task': idTask,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<dynamic> stopRecord(
    int id,
    String finish,
    String start,
    int idProject,
  ) async {
    final db = await DataBase().OpenDB();

    await db.update(
      'record',
      {'finish': finish, 'active': 0},
      where: 'id = ?',
      whereArgs: [id],
    );

    final date = finish.substring(0, finish.indexOf('T'));

    final second = DateTime.parse(
      finish,
    ).difference(DateTime.parse(start)).inSeconds;

    final data = await db.query(
      'activity',
      where: 'date = ?, id_project = ?',
      whereArgs: [date, idProject],
    );

    if (data.isEmpty) {
      await db.insert('activity', {
        'activity': 1,
        'date': date,
        'second': second,
        'id_project': idProject,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    } else {
      final activity = data.first['activity'] as int;
      final activitySecond = data.first['activity'] as int;

      await db.update(
        'activity',
        {'activity': activity + 1, 'second': activitySecond + second},
        where: 'date = ?, id_project = ?',
        whereArgs: [date, idProject],
      );
    }

    final dataTotal = await db.query(
      'total',
      where: 'id_project = ?',
      whereArgs: [idProject],
    );

    final totalSecond = dataTotal.first['second'] as int;
    final totalActivity = dataTotal.first['activity'] as int;

    await db.update(
      'total',
      {'second': totalSecond + second, 'activity': totalActivity + 1},
      where: 'id_project = ?',
      whereArgs: [idProject],
    );
  }
}
