import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackbuzz/features/project/domain/usecase/get_project_use_case.dart';
import 'package:trackbuzz/features/project/presentation/bloc/Project/project_event.dart';
import 'package:trackbuzz/features/project/presentation/bloc/Project/project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final GetProjectUseCase getProjectUseCase;

  ProjectBloc({required this.getProjectUseCase}) : super(ProjectInitial()) {
    on<GetProject>(_onGetProject);
  }

  Future<void> _onGetProject(
    GetProject event,
    Emitter<ProjectState> emit,
  ) async {
    emit(ProjectLoading());
    try {
      final project = await getProjectUseCase.execute(event.id);
      emit(ProjectLoaded(project: project));
    } catch (e) {
      emit(ProjectError(message: e.toString()));
    }
  }
}
