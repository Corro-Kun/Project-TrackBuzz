import 'package:trackbuzz/features/task/data/models/task_model.dart';

abstract class TaskRepositoryAbstract {
  Future<List<TaskModel>> getTasks(int id);
  Future<dynamic> createTask(String name, String description, int id);
}
