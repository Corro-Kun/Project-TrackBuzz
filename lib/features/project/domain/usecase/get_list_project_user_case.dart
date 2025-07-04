import 'package:trackbuzz/features/project/data/models/project_model.dart';
import 'package:trackbuzz/features/project/data/services/project_service.dart';

class GetListProjectUserCase {
  final ProjectService service;

  GetListProjectUserCase(this.service);

  Future<List<ProjectModel>> execute() async {
    return await service.getProjects();
  }
}
