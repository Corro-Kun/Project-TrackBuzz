import 'package:trackbuzz/features/task/data/services/task_service.dart';

class UpdateTaskUseCase {
  final TaskService service;

  UpdateTaskUseCase(this.service);

  Future<dynamic> execute(String name, String description, int id) async {
    return service.updateTask(name, description, id);
  }
}
