import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackbuzz/features/project/data/models/project_model.dart';
import 'package:trackbuzz/features/project/domain/usecase/get_project_use_case.dart';
import 'package:trackbuzz/features/project/domain/usecase/update_project_use_case.dart';
import 'package:trackbuzz/features/project/presentation/bloc/Project/project_event.dart';
import 'package:trackbuzz/features/project/presentation/bloc/Project/project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final GetProjectUseCase getProjectUseCase;
  final UpdateProjectUseCase updateProjectUseCase;

  ProjectBloc({
    required this.getProjectUseCase,
    required this.updateProjectUseCase,
  }) : super(ProjectInitial()) {
    on<GetProject>(_onGetProject);
    on<UpdateImage>(_onUpdateImage);
    on<UpdateTextProject>(_onUpdateTextProject);
    on<UpdateProject>(_onUpdateProject);
    on<UpdateBool>(_onUpdateBool);
  }

  Future<void> _onGetProject(
    GetProject event,
    Emitter<ProjectState> emit,
  ) async {
    emit(ProjectLoading());
    try {
      final project = await getProjectUseCase.execute(event.id);
      emit(ProjectLoaded(project: project, update: false));
    } catch (e) {
      emit(ProjectError(message: e.toString()));
    }
  }

  Future<void> _onUpdateImage(
    UpdateImage event,
    Emitter<ProjectState> emit,
  ) async {
    final currentState = state as ProjectLoaded;
    try {
      emit(
        ProjectLoaded(
          project: ProjectModel(
            id: currentState.project.id,
            title: currentState.project.title,
            image: event.path,
            state: currentState.project.state,
          ),
          update: false,
        ),
      );
    } catch (e) {
      emit(ProjectError(message: e.toString()));
    }
  }

  Future<void> _onUpdateTextProject(
    UpdateTextProject event,
    Emitter<ProjectState> emit,
  ) async {
    final currentState = state as ProjectLoaded;
    try {
      emit(
        ProjectLoaded(
          project: ProjectModel(
            id: currentState.project.id,
            title: event.title,
            image: currentState.project.image,
            state: currentState.project.state,
          ),
          update: false,
        ),
      );
    } catch (e) {
      emit(ProjectError(message: e.toString()));
    }
  }

  Future<void> _onUpdateProject(
    UpdateProject event,
    Emitter<ProjectState> emit,
  ) async {
    final currentState = state as ProjectLoaded;
    try {
      await updateProjectUseCase.execute(
        ProjectModel(
          id: currentState.project.id,
          title: event.title,
          image: event.img,
          state: currentState.project.state,
        ),
      );
    } catch (e) {
      emit(ProjectError(message: e.toString()));
    }
  }

  Future<void> _onUpdateBool(
    UpdateBool event,
    Emitter<ProjectState> emit,
  ) async {
    try {
      final project = await getProjectUseCase.execute(event.id);
      emit(ProjectLoaded(project: project, update: event.update));
    } catch (e) {
      emit(ProjectError(message: e.toString()));
    }
  }
}
