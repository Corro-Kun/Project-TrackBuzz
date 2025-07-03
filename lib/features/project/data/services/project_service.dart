import 'package:trackbuzz/features/project/domain/repositories/project_repository_abstract.dart';

class ProjectService {
  final ProjectRepositoryAbstract repository;

  ProjectService(this.repository);

  Future<dynamic> createProject(String title, String path) async {
    return await repository.createProject(title, path);
  }
}
