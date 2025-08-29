abstract class TaskEvent {}

class GetTasks extends TaskEvent {
  final int id;

  GetTasks({required this.id});
}

class DeleteTask extends TaskEvent {
  final int index;

  DeleteTask({required this.index});
}
