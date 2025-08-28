import 'package:trackbuzz/features/task/data/models/task_model.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<TaskModel> tasks;

  TaskLoaded({required this.tasks});
}

class TaskError extends TaskState {
  final String message;

  TaskError({required this.message});
}
