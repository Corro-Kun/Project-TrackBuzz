import 'package:trackbuzz/features/project/data/models/setting_model.dart';

abstract class SettingProjectState {}

class SettingProjectInitial extends SettingProjectState {}

class SettingProjectLoading extends SettingProjectState {}

class SettingProjectLoaded extends SettingProjectState {
  final SettingModel setting;

  SettingProjectLoaded({required this.setting});
}

class SettingProjectError extends SettingProjectState {
  final String message;

  SettingProjectError({required this.message});
}
