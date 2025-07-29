import 'package:trackbuzz/features/project/data/models/project_model.dart';
import 'package:trackbuzz/features/project/data/services/project_service.dart';

class UpdateProjectUseCase {
  final ProjectService service;

  UpdateProjectUseCase(this.service);

  Future<dynamic> execute(ProjectModel data) async {
    return await service.updateProject(data);
  }
}
