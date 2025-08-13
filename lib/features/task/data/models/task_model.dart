class TaskModel {
  int id;
  String name;
  String description;
  int state;
  int idProject;

  TaskModel({
    required this.id,
    required this.name,
    required this.description,
    required this.state,
    required this.idProject,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      state: json['state'],
      idProject: json['id_project'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'state': state,
      'id_project': idProject,
    };
  }
}
