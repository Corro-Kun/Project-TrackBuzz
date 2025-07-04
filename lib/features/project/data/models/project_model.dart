class ProjectModel {
  int id;
  String title;
  String image;
  int state;

  ProjectModel({
    required this.id,
    required this.title,
    required this.image,
    required this.state,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'image': image, 'state': state};
  }
}
