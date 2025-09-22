import 'package:trackbuzz/core/database/data_base.dart';

class ReportDatasource {
  Future<List<Map<String, dynamic>>> getTotal() async {
    final db = await DataBase().OpenDB();

    final data = await db.rawQuery("""
        SELECT p.id, p.title, p.image, t.second, t.activity
        FROM project p
        JOIN total t ON t.id_project = p.id
      """);

    return data;
  }

  Future<List<Map<String, dynamic>>> getReport() async {
    final db = await DataBase().OpenDB();

    final data = await db.rawQuery(
      '''
    SELECT record.*, project.title, project.image 
    FROM record
    INNER JOIN project ON record.id_project = project.id
    WHERE record.active = ?
    ORDER BY record.start DESC
    ''',
      [0],
    );

    return data;
  }
}
