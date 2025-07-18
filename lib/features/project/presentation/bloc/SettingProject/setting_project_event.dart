abstract class SettingProjectEvent {}

class GetSetting extends SettingProjectEvent {
  final int id;

  GetSetting({required this.id});
}

class ChangePrice extends SettingProjectEvent {
  final double price;

  ChangePrice({required this.price});
}

class ChangeCoin extends SettingProjectEvent {
  final String coin;

  ChangeCoin({required this.coin});
}
