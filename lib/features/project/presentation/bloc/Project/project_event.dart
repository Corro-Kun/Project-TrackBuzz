abstract class ProjectEvent {}

class GetProject extends ProjectEvent {
  final int id;

  GetProject({required this.id});
}

class UpdateImage extends ProjectEvent {
  final String path;

  UpdateImage({required this.path});
}

class UpdateTextProject extends ProjectEvent {
  final String title;

  UpdateTextProject({required this.title});
}

class UpdateDescriptionProject extends ProjectEvent {
  final String description;

  UpdateDescriptionProject({required this.description});
}

class UpdateProject extends ProjectEvent {
  final String title;
  final String? description;
  final String img;

  UpdateProject({required this.title, this.description, required this.img});
}

class UpdateBool extends ProjectEvent {
  final int id;
  final bool update;

  UpdateBool({required this.id, required this.update});
}
