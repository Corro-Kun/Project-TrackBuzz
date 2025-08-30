import 'package:trackbuzz/features/task/data/datasource/task_datasource.dart';
import 'package:trackbuzz/features/task/data/models/task_model.dart';
import 'package:trackbuzz/features/task/domain/repositories/task_repository_abstract.dart';

class TaskRepository extends TaskRepositoryAbstract {
  final TaskDatasource datasource;

  TaskRepository(this.datasource);

  @override
  Future<List<TaskModel>> getTasks(int id) async {
    final data = await datasource.getTasks(id);
    return List.generate(data.length, (i) {
      return TaskModel.fromJson(data[i]);
    });
  }

  @override
  Future createTask(String name, String description, int id) async {
    await datasource.createTask(name, description, id);
  }

  @override
  Future updateTask(String name, String description, int id) async {
    await datasource.updateTask(name, description, id);
  }

  @override
  Future deleteTask(int id) async {
    await datasource.deleteTask(id);
  }
}
