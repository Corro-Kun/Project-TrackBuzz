abstract class TaskEvent {}

class GetTasks extends TaskEvent {
  final int id;

  GetTasks({required this.id});
}
