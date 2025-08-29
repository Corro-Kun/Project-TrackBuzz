import 'package:trackbuzz/features/task/data/models/task_model.dart';
import 'package:trackbuzz/features/task/domain/repositories/task_repository_abstract.dart';

class TaskService {
  final TaskRepositoryAbstract repository;

  TaskService(this.repository);

  Future<List<TaskModel>> getTasks(int id) async {
    return await repository.getTasks(id);
  }

  Future<dynamic> createTask(String name, String description, int id) async {
    await repository.createTask(name, description, id);
  }

  Future<dynamic> deleteTask(int id) async {
    await repository.deleteTask(id);
  }
}
