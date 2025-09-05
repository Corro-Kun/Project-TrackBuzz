import 'package:trackbuzz/features/project/data/models/project_model.dart';
import 'package:trackbuzz/features/project/domain/repositories/project_repository_abstract.dart';

class ProjectService {
  final ProjectRepositoryAbstract repository;

  ProjectService(this.repository);

  Future<List<ProjectModel>> getProjects() async {
    return await repository.getProjects();
  }

  Future<ProjectModel> getProject(int id) async {
    return await repository.getProject(id);
  }

  Future<dynamic> createProject(
    String title,
    String? description,
    String path,
  ) async {
    return await repository.createProject(title, description, path);
  }

  Future<dynamic> updateProject(ProjectModel data) async {
    await repository.updateProject(data);
  }

  Future<dynamic> deleteProject(int id) async {
    await repository.deleteProject(id);
  }
}
