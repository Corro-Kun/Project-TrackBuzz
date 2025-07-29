abstract class ProjectEvent {}

class GetProject extends ProjectEvent {
  final int id;

  GetProject({required this.id});
}

class UpdateImage extends ProjectEvent {
  final String path;

  UpdateImage({required this.path});
}

class UpdateProject extends ProjectEvent {
  final String title;
  final String img;

  UpdateProject({required this.title, required this.img});
}
