import 'package:trackbuzz/features/project/data/models/project_model.dart';

abstract class ProjectRepositoryAbstract {
  Future<List<ProjectModel>> getProjects();
  Future<ProjectModel> getProject(int id);
  Future<dynamic> createProject(String title, String path);
}
