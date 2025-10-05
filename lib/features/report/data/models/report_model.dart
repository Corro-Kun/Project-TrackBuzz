class ReportModel {
  int id;
  String date;
  int activity;
  int second;
  int idProject;
  String title;
  String image;

  ReportModel({
    required this.id,
    required this.date,
    required this.activity,
    required this.second,
    required this.idProject,
    required this.title,
    required this.image,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'],
      date: json['date'],
      activity: json['activity'],
      second: json['second'],
      idProject: json['id_project'],
      title: json['title'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'activity': activity,
      'second': second,
      'id_project': idProject,
      'title': title,
      'image': image,
    };
  }
}
