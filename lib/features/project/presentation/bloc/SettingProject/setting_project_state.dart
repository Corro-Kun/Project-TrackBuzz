import 'package:trackbuzz/features/project/data/models/setting_model.dart';

abstract class SettingProjectState {}

class SettingProjectInitial extends SettingProjectState {}

class SettingProjectLoading extends SettingProjectState {}

class SettingProjectLoaded extends SettingProjectState {
  final SettingModel setting;
  final bool update;

  SettingProjectLoaded({required this.setting, required this.update});
}

class SettingProjectError extends SettingProjectState {
  final String message;

  SettingProjectError({required this.message});
}
