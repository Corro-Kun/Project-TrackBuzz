import 'package:bloc/bloc.dart';
import 'package:trackbuzz/features/project/domain/usecase/get_list_project_user_case.dart';
import 'package:trackbuzz/features/project/presentation/bloc/ListProject/list_project_event.dart';
import 'package:trackbuzz/features/project/presentation/bloc/ListProject/list_project_state.dart';

class ListProjectBloc extends Bloc<ListProjectEvent, ListProjectState> {
  final GetListProjectUserCase getListProject;

  ListProjectBloc({required this.getListProject})
    : super(ListProjectInitial()) {
    on<GetListProject>(_onGetListProject);
    on<SelectProject>(_onSelectProject);
    on<FilterProjects>(_onFilterProjects);
  }

  Future<void> _onGetListProject(
    GetListProject event,
    Emitter<ListProjectState> emit,
  ) async {
    emit(ListProjectLoading());
    try {
      final projects = await getListProject.execute();
      emit(ListProjectLoaded(projects: projects, index: 0));
    } catch (e) {
      emit(ListProjectError(message: e.toString()));
    }
  }

  Future<void> _onSelectProject(
    SelectProject event,
    Emitter<ListProjectState> emit,
  ) async {
    final currentState = state as ListProjectLoaded;
    try {
      emit(
        ListProjectLoaded(projects: currentState.projects, index: event.index),
      );
    } catch (e) {
      emit(ListProjectError(message: e.toString()));
    }
  }

  Future<void> _onFilterProjects(
    FilterProjects event,
    Emitter<ListProjectState> emit,
  ) async {
    final currentState = state as ListProjectLoaded;
    try {
      final list = currentState.projects
          .where(
            (element) => element.title.toLowerCase().contains(
              event.filter.toLowerCase(),
            ),
          )
          .toList();
      emit(ListProjectLoaded(projects: list, index: 0));
    } catch (e) {
      emit(ListProjectError(message: e.toString()));
    }
  }
}
