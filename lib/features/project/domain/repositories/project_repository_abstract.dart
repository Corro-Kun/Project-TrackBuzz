import 'package:trackbuzz/features/project/data/models/project_model.dart';

abstract class ProjectRepositoryAbstract {
  Future<List<ProjectModel>> getProjects();
  Future<dynamic> createProject(String title, String path);
}
