import 'package:trackbuzz/core/database/data_base.dart';

class RecordDatasource {
  Future<List<Map<String, dynamic>>> getRecord(int id, int page) async {
    final db = await DataBase().OpenDB();

    //final stopwatch = Stopwatch()..start();

    final data = await db.rawQuery(
      '''
  SELECT r.*, t.name as task_name 
  FROM record r 
  LEFT JOIN task t ON r.id_task = t.id 
  WHERE r.id_project = ? AND r.active = ? 
  ORDER BY r.start DESC
  LIMIT ? OFFSET ?
''',
      [id, 0, 20, page * 20],
    );
    //print('Consulta tomó: ${stopwatch.elapsedMilliseconds}ms');
    //print('Resultados: ${data.length}');

    return data;
  }

  Future<List<Map<String, dynamic>>> getRecordWithoutPage(int id) async {
    final db = await DataBase().OpenDB();

    final data = await db.rawQuery(
      '''
  SELECT r.*, t.name as task_name 
  FROM record r 
  LEFT JOIN task t ON r.id_task = t.id 
  WHERE r.id_project = ? AND r.active = ? 
  ORDER BY r.start ASC
''',
      [id, 0],
    );

    return data;
  }

  Future<List<Map<String, dynamic>>> getRecordWithTask(int id) async {
    final db = await DataBase().OpenDB();

    final data = await db.rawQuery(
      '''
  SELECT r.*, t.name as task_name 
  FROM task t
  LEFT JOIN record r ON r.id_task = t.id 
  WHERE r.id_project = ? AND r.active = ?
''',
      [id, 0],
    );

    return data;
  }

  Future<int> getSeconds(int id) async {
    final db = await DataBase().OpenDB();

    //final stopwatch = Stopwatch()..start();

    final result = await db.rawQuery(
      '''
      SELECT COALESCE(SUM(
      CASE 
        WHEN finish IS NOT NULL AND active = 1 THEN 
          (strftime('%s', finish) - strftime('%s', start))
        ELSE 0 
      END
    ), 0) as total_seconds
    FROM record 
    WHERE id_project = ?
      ''',
      [id],
    );

    //print('Consulta tomó: ${stopwatch.elapsedMilliseconds}ms');

    return result.first['total_seconds'] as int? ?? 0;
  }

  Future deleteRecord(int id, int idProject) async {
    final db = await DataBase().OpenDB();

    final records = await db.query(
      'record',
      where: 'id_project = ?',
      whereArgs: [idProject],
    );

    final date = records.first['finish'].toString().substring(
      0,
      records.first['finish'].toString().indexOf('T'),
    );

    final second = DateTime.parse(
      records.first['finish'].toString(),
    ).difference(DateTime.parse(records.first['start'].toString())).inSeconds;

    final data = await db.query(
      'activity',
      where: 'date = ? AND id_project = ?',
      whereArgs: [date, idProject],
    );

    if (int.parse(data.first['activity'].toString()) > 1) {
      await db.update(
        'activity',
        {
          'activity': int.parse(data.first['activity'].toString()) - 1,
          'second': int.parse(data.first['second'].toString()) - second,
        },
        where: 'date = ? AND id_project = ?',
        whereArgs: [date, idProject],
      );
    } else {
      await db.delete(
        'activity',
        where: 'date = ? AND id_project = ?',
        whereArgs: [date, idProject],
      );
    }

    final dataTotal = await db.query(
      'total',
      where: 'id_project = ?',
      whereArgs: [idProject],
    );

    await db.update(
      'total',
      {
        'second': int.parse(dataTotal.first['second'].toString()) - second,
        'activity': int.parse(dataTotal.first['activity'].toString()) - 1,
      },
      where: 'id_project = ?',
      whereArgs: [idProject],
    );

    await db.delete('record', where: 'id = ?', whereArgs: [id]);
  }
}
