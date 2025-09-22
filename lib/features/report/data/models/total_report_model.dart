class TotalReportModel {
  int id;
  String title;
  String image;
  int second;
  int activity;

  TotalReportModel({
    required this.id,
    required this.title,
    required this.image,
    required this.second,
    required this.activity,
  });

  factory TotalReportModel.fromJson(Map<String, dynamic> json) {
    return TotalReportModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      second: json['second'],
      activity: json['activity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'second': second,
      'activity': activity,
    };
  }
}
