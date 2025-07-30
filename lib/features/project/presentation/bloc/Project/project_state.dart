import 'package:trackbuzz/features/project/data/models/project_model.dart';

abstract class ProjectState {}

class ProjectInitial extends ProjectState {}

class ProjectLoading extends ProjectState {}

class ProjectLoaded extends ProjectState {
  final ProjectModel project;
  final bool update;

  ProjectLoaded({required this.project, required this.update});
}

class ProjectError extends ProjectState {
  final String message;

  ProjectError({required this.message});
}
