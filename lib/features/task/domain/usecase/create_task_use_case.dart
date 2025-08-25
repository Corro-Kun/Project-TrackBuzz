import 'package:trackbuzz/features/task/data/services/task_service.dart';

class CreateTaskUseCase {
  final TaskService service;

  CreateTaskUseCase(this.service);

  Future<dynamic> execute(String name, String description, int id) async {
    await service.createTask(name, description, id);
  }
}
