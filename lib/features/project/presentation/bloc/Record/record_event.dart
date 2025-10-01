abstract class RecordEvent {}

class GetRecord extends RecordEvent {
  final int id;

  GetRecord({required this.id});
}

class GetRecordByPage extends RecordEvent {
  final int id;

  GetRecordByPage({required this.id});
}
