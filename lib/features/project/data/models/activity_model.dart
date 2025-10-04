class ActivityModel {
  int id;
  String date;
  int activity;
  int second;
  int idProject;

  ActivityModel({
    required this.id,
    required this.date,
    required this.activity,
    required this.second,
    required this.idProject,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      id: json['id'],
      date: json['date'],
      activity: json['activity'],
      second: json['second'],
      idProject: json['id_project'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'activity': activity,
      'second': second,
      'id_project': idProject,
    };
  }
}
