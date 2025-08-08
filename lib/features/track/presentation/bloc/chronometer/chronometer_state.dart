import 'package:trackbuzz/features/track/data/models/record_model.dart';

abstract class ChronometerState {}

class ChronometerInitial extends ChronometerState {}

class ChronometerLoading extends ChronometerState {}

class ChronometerLoaded extends ChronometerState {
  final RecordModel? record;

  ChronometerLoaded({required this.record});
}

class ChronometerError extends ChronometerState {
  final String message;

  ChronometerError({required this.message});
}
