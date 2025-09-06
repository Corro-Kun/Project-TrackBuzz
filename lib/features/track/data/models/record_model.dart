class RecordModel {
  int id;
  String start;
  String? finish;
  int active;
  int? idTask;
  int idProject;
  String? taskName;

  RecordModel({
    required this.id,
    required this.start,
    required this.finish,
    required this.active,
    required this.idProject,
    required this.idTask,
    this.taskName,
  });

  factory RecordModel.fromJson(Map<String, dynamic> json) {
    return RecordModel(
      id: json['id'],
      start: json['start'],
      finish: json['finish'],
      active: json['active'],
      idProject: json['id_project'],
      idTask: json['id_task'],
      taskName: json['task_name'],
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
      'task_name': taskName,
    };
  }
}
