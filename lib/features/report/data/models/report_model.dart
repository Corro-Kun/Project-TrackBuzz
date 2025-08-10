class ReportModel {
  int id;
  String start;
  String finish;
  int active;
  int? idTask;
  int idProject;
  String title;
  String image;

  ReportModel({
    required this.id,
    required this.start,
    required this.finish,
    required this.active,
    required this.idProject,
    required this.idTask,
    required this.title,
    required this.image,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'],
      start: json['start'],
      finish: json['finish'],
      active: json['active'],
      idProject: json['id_project'],
      idTask: json['id_task'],
      title: json['title'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'start': start,
      'finish': finish,
      'active': active,
      'id_task': idTask,
      'id_project': idProject,
      'title': title,
      'image': image,
    };
  }
}
