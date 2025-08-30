import 'package:trackbuzz/features/project/data/services/project_service.dart';

class CreateProjectUseCase {
  final ProjectService service;

  CreateProjectUseCase(this.service);

  Future<dynamic> execute(
    String title,
    String? description,
    String path,
  ) async {
    await service.createProject(title, description, path);
  }
}
