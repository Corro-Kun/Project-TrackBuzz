import 'package:trackbuzz/features/project/data/models/project_model.dart';
import 'package:trackbuzz/features/project/data/services/project_service.dart';

class GetSettingProjectUseCase {
  final ProjectService service;

  GetSettingProjectUseCase(this.service);

  Future<dynamic> execute(ProjectModel data) async {
    return await service.updateProject(data);
  }
}
