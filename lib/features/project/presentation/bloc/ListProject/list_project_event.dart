abstract class ListProjectEvent {}

class GetListProject extends ListProjectEvent {}

class SelectProject extends ListProjectEvent {
  final int index;
  SelectProject({required this.index});
}

class FilterProjects extends ListProjectEvent {
  final String filter;
  FilterProjects({required this.filter});
}
