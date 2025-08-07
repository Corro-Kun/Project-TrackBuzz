import 'package:bloc/bloc.dart';
import 'package:trackbuzz/features/track/domain/usecase/get_list_project_chronometer_use_case.dart';
import 'package:trackbuzz/features/track/presentation/bloc/Project/project_chronometer_event.dart';
import 'package:trackbuzz/features/track/presentation/bloc/Project/project_chronometer_state.dart';

class ProjectChronometerBloc
    extends Bloc<ProjectChronometerEvent, ProjectChronometerState> {
  final GetListProjectChronometerUseCase getListProjectChronometerUseCase;

  ProjectChronometerBloc({required this.getListProjectChronometerUseCase})
    : super(ProjectChronometerInitial()) {
    on<GetProjects>(_onGetProjects);
    on<SelectProject>(_onSelectProject);
  }

  Future<void> _onGetProjects(
    GetProjects event,
    Emitter<ProjectChronometerState> emit,
  ) async {
    emit(ProjectChronometerInitial());
    try {
      final projects = await getListProjectChronometerUseCase.execute();
      emit(ProjectChronometerLoaded(projects: projects, index: null));
    } catch (e) {
      emit(ProjectChronometerError(message: e.toString()));
    }
  }

  void _onSelectProject(
    SelectProject event,
    Emitter<ProjectChronometerState> emit,
  ) async {
    final currentState = state as ProjectChronometerLoaded;
    try {
      int? index;
      for (var i = 0; i < currentState.projects.length - 1; i++) {
        if (currentState.projects[i].id == event.id) {
          index = i;
          break;
        }
      }
      emit(
        ProjectChronometerLoaded(projects: currentState.projects, index: index),
      );
    } catch (e) {
      emit(ProjectChronometerError(message: e.toString()));
    }
  }
}
