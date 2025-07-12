abstract class SettingProjectEvent {}

class GetSetting extends SettingProjectEvent {
  final int id;

  GetSetting({required this.id});
}
