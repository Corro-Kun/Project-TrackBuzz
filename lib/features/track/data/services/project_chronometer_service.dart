import 'package:trackbuzz/features/project/data/models/project_model.dart';
import 'package:trackbuzz/features/project/domain/repositories/project_repository_abstract.dart';

class ProjectChronometerService {
  final ProjectRepositoryAbstract repository;

  ProjectChronometerService(this.repository);

  Future<List<ProjectModel>> getProjects(bool state) async {
    return await repository.getProjects(state: state);
  }
}
