import 'package:trackbuzz/features/project/data/models/project_model.dart';

abstract class ListProjectState {}

class ListProjectInitial extends ListProjectState {}

class ListProjectLoading extends ListProjectState {}

class ListProjectLoaded extends ListProjectState {
  final List<ProjectModel> projects;
  final int index;

  ListProjectLoaded({required this.projects, required this.index});
}

class ListProjectError extends ListProjectState {
  final String message;

  ListProjectError({required this.message});
}
