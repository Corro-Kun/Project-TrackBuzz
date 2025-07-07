import 'package:trackbuzz/features/project/data/models/project_model.dart';

abstract class ProjectState {}

class ProjectInitial extends ProjectState {}

class ProjectLoading extends ProjectState {}

class ProjectLoaded extends ProjectState {
  final ProjectModel project;

  ProjectLoaded({required this.project});
}

class ProjectError extends ProjectState {
  final String message;

  ProjectError({required this.message});
}
