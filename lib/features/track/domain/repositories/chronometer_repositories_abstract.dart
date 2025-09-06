import 'package:trackbuzz/features/track/data/models/record_model.dart';

abstract class ChronometerRepositoriesAbstract {
  Future<List<RecordModel>> getCurrentRecord();
  Future<dynamic> startRecord(String start, int idProject, int? idTask);
  Future<dynamic> stopRecord(int id, String finish);
}
