abstract class ChronometerEvent {}

class GetCurrent extends ChronometerEvent {}

class StartRecord extends ChronometerEvent {
  final String start;
  final int id;

  StartRecord({required this.start, required this.id});
}

class StopRecord extends ChronometerEvent {
  final int id;
  final String finish;

  StopRecord({required this.id, required this.finish});
}
