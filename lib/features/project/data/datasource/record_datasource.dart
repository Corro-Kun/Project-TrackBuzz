import 'package:trackbuzz/core/database/data_base.dart';

class RecordDatasource {
  Future<List<Map<String, dynamic>>> getRecord(int id) async {
    final db = await DataBase().OpenDB();

    final data = await db.query(
      'record',
      where: 'id_project = ? AND active = ?',
      whereArgs: [id, 0],
      orderBy: 'start DESC',
    );

    return data;
  }
}
