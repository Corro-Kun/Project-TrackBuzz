import 'package:trackbuzz/features/project/data/services/project_service.dart';

class DeleteProjectUseCase {
  final ProjectService service;

  DeleteProjectUseCase(this.service);

  Future<dynamic> execute(int id) async {
    await service.deleteProject(id);
  }
}
