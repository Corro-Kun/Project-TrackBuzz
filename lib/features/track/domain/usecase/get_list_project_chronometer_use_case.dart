import 'package:trackbuzz/features/project/data/models/project_model.dart';
import 'package:trackbuzz/features/track/data/services/project_chronometer_service.dart';

class GetListProjectChronometerUseCase {
  final ProjectChronometerService service;

  GetListProjectChronometerUseCase(this.service);

  Future<List<ProjectModel>> execute({bool? state = false}) async {
    return await service.getProjects(state ?? false);
  }
}
