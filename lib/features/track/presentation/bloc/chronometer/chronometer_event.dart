abstract class ChronometerEvent {}

class GetCurrent extends ChronometerEvent {}

class StartRecord extends ChronometerEvent {
  final String start;
  final int id;
  final int? idTask;

  StartRecord({required this.start, required this.id, this.idTask});
}

class StopRecord extends ChronometerEvent {
  final int id;
  final String finish;

  StopRecord({required this.id, required this.finish});
}
