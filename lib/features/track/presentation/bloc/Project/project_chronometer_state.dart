import 'package:trackbuzz/features/project/data/models/project_model.dart';

abstract class ProjectChronometerState {}

class ProjectChronometerInitial extends ProjectChronometerState {}

class ProjectChronometerLoading extends ProjectChronometerState {}

class ProjectChronometerLoaded extends ProjectChronometerState {
  final List<ProjectModel> projects;
  final int? index;

  ProjectChronometerLoaded({required this.projects, required this.index});
}

class ProjectChronometerError extends ProjectChronometerState {
  final String message;

  ProjectChronometerError({required this.message});
}
