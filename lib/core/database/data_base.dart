import 'package:sqflite/sqflite.dart';

class DataBase {
  Future<Database> OpenDB() async {
    final Future<Database> _dataBase = openDatabase(
      'trackbuzz.db',
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE project(id INTEGER PRIMARY KEY, title TEXT, description TEXT DEFAULT null, image TEXT, state INTEGER DEFAULT 0)',
        );
        db.execute(
          "CREATE TABLE project_settings(id INTEGER PRIMARY KEY, bill INTEGER DEFAULT 0, price REAL DEFAULT 0, coin TEXT DEFAULT 'USD', id_project INTEGER, FOREIGN KEY(id_project) REFERENCES project(id))",
        );
        db.execute(
          'CREATE TABLE task(id INTEGER PRIMARY KEY, name TEXT, description TEXT, state INTEGER DEFAULT 0, id_project INTEGER, FOREIGN KEY(id_project) REFERENCES project(id))',
        );
        db.execute(
          'CREATE TABLE record(id INTEGER PRIMARY KEY, start TEXT, finish TEXT DEFAULT NULL, active INTEGER DEFAULT 1, id_task INTEGER DEFAULT NULL, id_project INTEGER, FOREIGN KEY(id_task) REFERENCES task(id), FOREIGN KEY(id_project) REFERENCES project(id))',
        );
        db.insert('project', {
          'title': 'do nothing',
          'image': 'lib/assets/img/example',
        });
        db.insert('project_settings', {'id_project': 1});
      },

      version: 1,
    );

    return _dataBase;
  }
}
