import 'package:trackbuzz/features/project/data/models/activity_model.dart';

abstract class ActivityRepositoryAbstract {
  Future<List<ActivityModel>> getActivity(int id);
}
