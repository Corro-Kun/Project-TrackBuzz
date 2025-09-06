import 'package:trackbuzz/core/database/data_base.dart';

class RecordDatasource {
  Future<List<Map<String, dynamic>>> getRecord(int id) async {
    final db = await DataBase().OpenDB();

    final data = await db.rawQuery(
      '''
  SELECT r.*, t.name as task_name 
  FROM record r 
  LEFT JOIN task t ON r.id_task = t.id 
  WHERE r.id_project = ? AND r.active = ? 
  ORDER BY r.start DESC
''',
      [id, 0],
    );

    return data;
  }
}
