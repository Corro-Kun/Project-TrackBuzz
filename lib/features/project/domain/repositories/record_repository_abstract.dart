import 'package:trackbuzz/features/track/data/models/record_model.dart';

abstract class RecordRepositoryAbstract {
  Future<List<RecordModel>> getProject(int id);
}
