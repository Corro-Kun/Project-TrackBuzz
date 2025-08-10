import 'package:trackbuzz/core/database/data_base.dart';

class ReportDatasource {
  Future<List<Map<String, dynamic>>> getReport() async {
    final db = await DataBase().OpenDB();

    final data = await db.rawQuery('''
    SELECT record.*, project.title, project.image 
    FROM record
    INNER JOIN project ON record.id_project = project.id
    WHERE record.active = 1
    ''');

    return data;
  }
}
