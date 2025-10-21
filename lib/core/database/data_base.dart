import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBase {
  static const String _dbName = 'trackbuzz.db';

  Future<Database> OpenDB() async {
    final Future<Database> _dataBase = openDatabase(
      _dbName,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE project(id INTEGER PRIMARY KEY, title TEXT, description TEXT DEFAULT null, image TEXT, state INTEGER DEFAULT 0)',
        );
        db.execute(
          "CREATE TABLE project_settings(id INTEGER PRIMARY KEY, bill INTEGER DEFAULT 0, description INTEGER DEFAULT 0,price REAL DEFAULT 0, coin TEXT DEFAULT 'USD', id_project INTEGER, FOREIGN KEY(id_project) REFERENCES project(id))",
        );
        db.execute(
          'CREATE TABLE task(id INTEGER PRIMARY KEY, name TEXT, description TEXT, state INTEGER DEFAULT 0, id_project INTEGER, FOREIGN KEY(id_project) REFERENCES project(id))',
        );
        db.execute(
          'CREATE TABLE record(id INTEGER PRIMARY KEY, start TEXT, finish TEXT DEFAULT NULL, active INTEGER DEFAULT 1, id_task INTEGER DEFAULT NULL, id_project INTEGER, FOREIGN KEY(id_task) REFERENCES task(id), FOREIGN KEY(id_project) REFERENCES project(id))',
        );
        db.execute(
          'CREATE TABLE total(id INTEGER PRIMARY KEY, second INTEGER, activity INTEGER, id_project INTEGER, FOREIGN KEY(id_project) REFERENCES project(id))',
        );
        db.execute(
          'CREATE TABLE activity(id INTEGER PRIMARY KEY, date TEXT, activity INTEGER, second INTEGER, id_project INTEGER, FOREIGN KEY(id_project) REFERENCES project(id))',
        );
        db.execute(
          'CREATE INDEX idx_record_project_active ON record(id_project, active)',
        );
        db.execute('CREATE INDEX idx_record_start ON record(start)');
        db.execute(
          'CREATE INDEX idx_record_project_task ON record(id_project, id_task)',
        );
        db.insert('project', {
          'title': 'do nothing',
          'image': 'lib/assets/img/example',
        });
        db.insert('project_settings', {'id_project': 1});
        db.insert('total', {'second': 0, 'activity': 0, 'id_project': 1});
      },

      version: 1,
    );

    return _dataBase;
  }

  Future<String> getDatabasePath() async {
    final databasesPath = await getDatabasesPath();
    return '$databasesPath/$_dbName';
  }

  Future<Directory> getImagesDirectory() async {
    final Directory? appDocDir = await getExternalStorageDirectory();
    final String path = appDocDir!.path;
    final Directory imagesDir = Directory('$path/images');
    if (!await imagesDir.exists()) {
      await imagesDir.create(recursive: true);
    }
    return imagesDir;
  }

  Future<File?> getImageFile(String imagePath) async {
    final file = File(imagePath);
    if (await file.exists()) {
      return file;
    }
    return null;
  }

  Future<File> exportToZip(String directory) async {
    try {
      final archive = Archive();

      final dbPath = await getDatabasePath();
      final dbFile = File(dbPath);
      if (await dbFile.exists()) {
        final dbData = await dbFile.readAsBytes();
        archive.addFile(ArchiveFile(_dbName, dbData.length, dbData));
      }

      final imagesDirectory = await getImagesDirectory();

      if (await imagesDirectory.exists()) {
        final imageFiles = await imagesDirectory
            .list()
            .where((entity) => entity is File)
            .toList();

        for (final entity in imageFiles) {
          final file = entity as File;
          final fileData = await file.readAsBytes();
          final relativePath =
              'images/${file.path.substring(file.path.lastIndexOf('/'))}';
          archive.addFile(ArchiveFile(relativePath, fileData.length, fileData));
        }
      }

      final zipData = ZipEncoder().encode(archive);
      if (zipData == null) {
        throw Exception('Error al crear el archivo ZIP');
      }

      /*
      final directory = await getExternalStorageDirectory();
      
      final Directory dir = Directory('${directory!.path}/backup');
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final zipPath =
          '${dir.path.substring(0, dir.path.indexOf('Android'))}Download/trackbuzz_backup_$timestamp.zip';
      
      */

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final zipPath = '$directory/trackbuzz_backup_$timestamp.zip';

      final zipFile = File(zipPath);
      await zipFile.writeAsBytes(zipData);

      return zipFile;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> importFromZip(File zipFile) async {
    try {
      final zipData = await zipFile.readAsBytes();
      final archive = ZipDecoder().decodeBytes(zipData);

      for (final file in archive.files) {
        if (file.isFile) {
          final data = file.content as List<int>;
          final bytes = Uint8List.fromList(data);

          if (file.name == _dbName) {
            final dbPath = await getDatabasePath();
            final dbFile = File(dbPath);
            await dbFile.writeAsBytes(bytes);
          } else {
            final imagesDir = await getImagesDirectory();
            final imagePath =
                '${imagesDir.path}/${file.name.substring(file.name.lastIndexOf('/'))}';
            final imageFile = File(imagePath);
            await imageFile.writeAsBytes(bytes);
          }
        }
      }

      await zipFile.delete();
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
