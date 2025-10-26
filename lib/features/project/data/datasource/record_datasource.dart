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
}
