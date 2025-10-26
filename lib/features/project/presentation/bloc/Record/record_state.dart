import 'package:trackbuzz/features/project/data/models/activity_model.dart';
import 'package:trackbuzz/features/track/data/models/record_model.dart';

abstract class RecordState {}

class RecordInitial extends RecordState {}

class RecordLoading extends RecordState {}

class RecordLoaded extends RecordState {
  final List<RecordModel> records;
  final List<ActivityModel> activity;
  final List<RecordModel> recordTasks;
  final int page;

  RecordLoaded({
    required this.records,
    required this.activity,
    required this.recordTasks,
    required this.page,
  });
}

class RecordError extends RecordState {
  final String message;

  RecordError({required this.message});
}
