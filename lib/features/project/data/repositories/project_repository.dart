import 'package:trackbuzz/features/project/data/datasource/project_datasource.dart';
import 'package:trackbuzz/features/project/data/models/project_model.dart';
import 'package:trackbuzz/features/project/domain/repositories/project_repository_abstract.dart';

class ProjectRepository extends ProjectRepositoryAbstract {
  final ProjectDatasource datasource;

  ProjectRepository(this.datasource);

  @override
  Future<List<ProjectModel>> getProjects() async {
    final data = await datasource.getProjects();
    return List.generate(data.length, (i) {
      return ProjectModel.fromJson(data[i]);
    });
  }

  @override
  Future<ProjectModel> getProject(int id) async {
    final data = await datasource.getProject(id);

    return ProjectModel.fromJson(data);
  }

  @override
  Future<dynamic> createProject(
    String title,
    String? description,
    String path,
  ) async {
    return await datasource.createProject(title, description, path);
  }

  @override
  Future updateProject(ProjectModel data) async {
    await datasource.updateProject(
      data.id,
      data.title,
      data.description,
      data.image,
    );
  }
}
