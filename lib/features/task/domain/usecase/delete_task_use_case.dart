import 'package:trackbuzz/features/task/data/services/task_service.dart';

class DeleteTaskUseCase {
  final TaskService service;

  DeleteTaskUseCase(this.service);

  Future<dynamic> execute(int id) async {
    await service.deleteTask(id);
  }
}
