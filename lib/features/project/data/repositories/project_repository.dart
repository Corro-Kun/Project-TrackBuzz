import 'package:trackbuzz/features/project/data/datasource/project_datasource.dart';
import 'package:trackbuzz/features/project/domain/repositories/project_repository_abstract.dart';

class ProjectRepository extends ProjectRepositoryAbstract {
  final ProjectDatasource datasource;

  ProjectRepository(this.datasource);

  @override
  Future<dynamic> createProject(String title, String path) async {
    return await datasource.CreateProject(title, path);
  }
}
