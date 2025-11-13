import 'package:bloc/bloc.dart';
import 'package:trackbuzz/features/task/domain/usecase/get_list_task_use_case.dart';
import 'package:trackbuzz/features/track/domain/usecase/get_list_project_chronometer_use_case.dart';
import 'package:trackbuzz/features/track/presentation/bloc/Project/project_chronometer_event.dart';
import 'package:trackbuzz/features/track/presentation/bloc/Project/project_chronometer_state.dart';

class ProjectChronometerBloc
    extends Bloc<ProjectChronometerEvent, ProjectChronometerState> {
  final GetListProjectChronometerUseCase getListProjectChronometerUseCase;
  final GetListTaskUseCase getListTaskUseCase;

  ProjectChronometerBloc({
    required this.getListProjectChronometerUseCase,
    required this.getListTaskUseCase,
  }) : super(ProjectChronometerInitial()) {
    on<GetProjects>(_onGetProjects);
    on<SelectProject>(_onSelectProject);
    on<DeleteSelectProject>(_onDeleteSelectProject);
    on<SelectTask>(_onSelectTask);
    on<DeleteTask>(_onDeleteTask);
    on<InitProjectAndTask>(_onInitProjectAndTask);
  }

  Future<void> _onGetProjects(
    GetProjects event,
    Emitter<ProjectChronometerState> emit,
  ) async {
    emit(ProjectChronometerInitial());
    try {
      final projects = await getListProjectChronometerUseCase.execute(
        state: true,
      );
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
      for (var i = 0; i < currentState.projects.length; i++) {
        if (currentState.projects[i].id == event.id) {
          index = i;
          break;
        }
      }
      final tasks = await getListTaskUseCase.execute(event.id);
      emit(
        ProjectChronometerLoaded(
          projects: currentState.projects,
          index: index,
          tasks: tasks,
        ),
      );
    } catch (e) {
      emit(ProjectChronometerError(message: e.toString()));
    }
  }

  void _onDeleteSelectProject(
    DeleteSelectProject event,
    Emitter<ProjectChronometerState> emit,
  ) async {
    final currentState = state as ProjectChronometerLoaded;
    try {
      emit(
        ProjectChronometerLoaded(projects: currentState.projects, index: null),
      );
    } catch (e) {
      emit(ProjectChronometerError(message: e.toString()));
    }
  }

  void _onSelectTask(
    SelectTask event,
    Emitter<ProjectChronometerState> emit,
  ) async {
    final currentState = state as ProjectChronometerLoaded;
    try {
      int? index;
      for (var i = 0; i < currentState.tasks!.length; i++) {
        if (currentState.tasks![i].id == event.id) {
          index = i;
          break;
        }
      }
      emit(
        ProjectChronometerLoaded(
          projects: currentState.projects,
          index: currentState.index,
          tasks: currentState.tasks,
          indexTask: index,
        ),
      );
    } catch (e) {
      emit(ProjectChronometerError(message: e.toString()));
    }
  }

  void _onDeleteTask(
    DeleteTask event,
    Emitter<ProjectChronometerState> emit,
  ) async {
    final currentState = state as ProjectChronometerLoaded;
    try {
      emit(
        ProjectChronometerLoaded(
          projects: currentState.projects,
          index: currentState.index,
          tasks: currentState.tasks,
          indexTask: null,
        ),
      );
    } catch (e) {
      emit(ProjectChronometerError(message: e.toString()));
    }
  }

  void _onInitProjectAndTask(
    InitProjectAndTask event,
    Emitter<ProjectChronometerState> emit,
  ) async {
    final currentState = state as ProjectChronometerLoaded;
    try {
      int? indexProject;
      for (var i = 0; i < currentState.projects.length; i++) {
        if (currentState.projects[i].id == event.idProject) {
          indexProject = i;
          break;
        }
      }

      emit(
        ProjectChronometerLoaded(
          projects: currentState.projects,
          index: indexProject,
        ),
      );

      final tasks = await getListTaskUseCase.execute(event.idProject);

      int? indexTask;
      for (var i = 0; i < tasks.length; i++) {
        if (tasks[i].id == event.idTask) {
          indexTask = i;
          break;
        }
      }

      emit(
        ProjectChronometerLoaded(
          projects: currentState.projects,
          index: indexProject,
          tasks: tasks,
          indexTask: indexTask,
        ),
      );
    } catch (e) {
      emit(ProjectChronometerError(message: e.toString()));
    }
  }
}
