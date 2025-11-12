abstract class SettingProjectEvent {}

class GetSetting extends SettingProjectEvent {
  final int id;

  GetSetting({required this.id});
}

class ChangeState extends SettingProjectEvent {
  final int state;

  ChangeState({required this.state});
}

class ChangeBill extends SettingProjectEvent {
  final int bill;

  ChangeBill({required this.bill});
}

class ChangeDescription extends SettingProjectEvent {
  final int description;

  ChangeDescription({required this.description});
}

class ChangePrice extends SettingProjectEvent {
  final double price;

  ChangePrice({required this.price});
}

class ChangeCoin extends SettingProjectEvent {
  final String coin;

  ChangeCoin({required this.coin});
}

class UpdateSetting extends SettingProjectEvent {}
