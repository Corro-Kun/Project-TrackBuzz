class ProjectModel {
  int id;
  String title;
  String? description;
  String image;
  int state;

  ProjectModel({
    required this.id,
    required this.title,
    this.description,
    required this.image,
    required this.state,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'state': state,
    };
  }
}
