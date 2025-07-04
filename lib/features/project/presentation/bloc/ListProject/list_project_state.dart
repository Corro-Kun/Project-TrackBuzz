import 'package:trackbuzz/features/project/data/models/project_model.dart';

abstract class ListProjectState {}

class ListProjectInitial extends ListProjectState {}

class ListProjectLoading extends ListProjectState {}

class ListProjectLoaded extends ListProjectState {
  final List<ProjectModel> projects;

  ListProjectLoaded({required this.projects});
}

class ListProjectError extends ListProjectState {
  final String message;

  ListProjectError({required this.message});
}
