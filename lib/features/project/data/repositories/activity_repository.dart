import 'package:trackbuzz/features/project/data/datasource/activity_datasource.dart';
import 'package:trackbuzz/features/project/data/models/activity_model.dart';
import 'package:trackbuzz/features/project/domain/repositories/activity_repository_abstract.dart';

class ActivityRepository extends ActivityRepositoryAbstract {
  final ActivityDatasource datasource;

  ActivityRepository(this.datasource);

  @override
  Future<List<ActivityModel>> getActivity(int id) async {
    final data = await datasource.getActivity(id);

    return List.generate(data.length, (i) {
      return ActivityModel.fromJson(data[i]);
    });
  }
}
