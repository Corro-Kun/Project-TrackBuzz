import 'package:trackbuzz/features/report/data/models/report_model.dart';

abstract class ReportState {}

class ReportInitial extends ReportState {}

class ReportLoading extends ReportState {}

class ReportLoaded extends ReportState {
  final List<ReportModel> reports;
  final int seconds;

  ReportLoaded({required this.reports, required this.seconds});
}

class ReportError extends ReportState {
  final String message;

  ReportError({required this.message});
}
