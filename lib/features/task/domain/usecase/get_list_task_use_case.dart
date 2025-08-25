import 'package:trackbuzz/features/task/data/services/task_service.dart';

class GetListTaskUseCase {
  final TaskService service;

  GetListTaskUseCase(this.service);

  Future<dynamic> execute(int id) async {
    return service.getTasks(id);
  }
}
