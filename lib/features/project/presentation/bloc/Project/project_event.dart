abstract class ProjectEvent {}

class GetProject extends ProjectEvent {
  final int id;

  GetProject({required this.id});
}
