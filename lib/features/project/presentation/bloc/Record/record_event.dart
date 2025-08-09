abstract class RecordEvent {}

class GetRecord extends RecordEvent {
  final int id;

  GetRecord({required this.id});
}
