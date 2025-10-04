import 'package:trackbuzz/features/project/data/models/activity_model.dart';
import 'package:trackbuzz/features/project/domain/repositories/activity_repository_abstract.dart';

class ActivityService {
  final ActivityRepositoryAbstract repository;

  ActivityService(this.repository);

  Future<List<ActivityModel>> getActivity(int id) {
    return repository.getActivity(id);
  }
}
