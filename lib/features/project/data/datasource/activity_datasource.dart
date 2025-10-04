import 'package:trackbuzz/core/database/data_base.dart';

class ActivityDatasource {
  Future<List<Map<String, dynamic>>> getActivity(int id) async {
    final db = await DataBase().OpenDB();

    final data = db.query('activity', where: 'id_project = ?', whereArgs: [id]);

    return data;
  }
}
