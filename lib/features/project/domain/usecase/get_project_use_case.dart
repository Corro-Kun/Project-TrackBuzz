import 'package:trackbuzz/features/project/data/models/project_model.dart';
import 'package:trackbuzz/features/project/data/services/project_service.dart';

class GetProjectUseCase {
  final ProjectService service;

  GetProjectUseCase(this.service);

  Future<ProjectModel> execute(int id) async {
    return await service.getProject(id);
  }
}
