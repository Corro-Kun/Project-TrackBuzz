abstract class ProjectChronometerEvent {}

class GetProjects extends ProjectChronometerEvent {}

class SelectProject extends ProjectChronometerEvent {
  final int id;

  SelectProject({required this.id});
}

class DeleteSelectProject extends ProjectChronometerEvent {}
