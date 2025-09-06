import 'package:trackbuzz/features/project/data/models/project_model.dart';
import 'package:trackbuzz/features/task/data/models/task_model.dart';

abstract class ProjectChronometerState {}

class ProjectChronometerInitial extends ProjectChronometerState {}

class ProjectChronometerLoading extends ProjectChronometerState {}

class ProjectChronometerLoaded extends ProjectChronometerState {
  final List<ProjectModel> projects;
  final List<TaskModel>? tasks;
  final int? index;
  final int? indexTask;

  ProjectChronometerLoaded({
    required this.projects,
    required this.index,
    this.tasks,
    this.indexTask,
  });
}

class ProjectChronometerError extends ProjectChronometerState {
  final String message;

  ProjectChronometerError({required this.message});
}
