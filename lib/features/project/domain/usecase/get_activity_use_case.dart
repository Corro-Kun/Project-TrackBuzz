import 'package:trackbuzz/features/project/data/models/activity_model.dart';
import 'package:trackbuzz/features/project/data/services/activity_service.dart';

class GetActivityUseCase {
  final ActivityService service;

  GetActivityUseCase(this.service);

  Future<List<ActivityModel>> execute(int id) async {
    return await service.getActivity(id);
  }
}
