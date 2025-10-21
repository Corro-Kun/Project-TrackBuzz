class SettingModel {
  int id;
  int bill;
  int description;
  double price;
  String coin;
  int idProject;

  SettingModel({
    required this.id,
    required this.bill,
    required this.description,
    required this.price,
    required this.coin,
    required this.idProject,
  });

  factory SettingModel.fromJson(Map<String, dynamic> json) {
    return SettingModel(
      id: json['id'],
      bill: json['bill'],
      description: json['description'],
      price: json['price'],
      coin: json['coin'],
      idProject: json['id_project'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bill': bill,
      'description': description,
      'price': price,
      'coin': coin,
      'id_project': idProject,
    };
  }
}
