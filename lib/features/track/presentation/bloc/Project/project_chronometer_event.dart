abstract class ProjectChronometerEvent {}

class GetProjects extends ProjectChronometerEvent {}

class SelectProject extends ProjectChronometerEvent {
  final int id;

  SelectProject({required this.id});
}

class DeleteSelectProject extends ProjectChronometerEvent {}

class SelectTask extends ProjectChronometerEvent {
  final int id;

  SelectTask({required this.id});
}

class DeleteTask extends ProjectChronometerEvent {}

class InitProjectAndTask extends ProjectChronometerEvent {
  final int idProject;
  final int idTask;

  InitProjectAndTask({required this.idProject, required this.idTask});
}
