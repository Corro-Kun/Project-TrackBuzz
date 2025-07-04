import 'package:bloc/bloc.dart';
import 'package:trackbuzz/features/project/domain/usecase/get_list_project_user_case.dart';
import 'package:trackbuzz/features/project/presentation/bloc/ListProject/list_project_event.dart';
import 'package:trackbuzz/features/project/presentation/bloc/ListProject/list_project_state.dart';

class ListProjectBloc extends Bloc<ListProjectEvent, ListProjectState> {
  final GetListProjectUserCase getListProject;

  ListProjectBloc({required this.getListProject})
    : super(ListProjectInitial()) {
    on<GetListProject>(_onGetListProject);
  }

  Future<void> _onGetListProject(
    GetListProject event,
    Emitter<ListProjectState> emit,
  ) async {
    emit(ListProjectLoading());
    try {
      final projects = await getListProject.execute();
      emit(ListProjectLoaded(projects: projects));
    } catch (e) {
      emit(ListProjectError(message: e.toString()));
    }
  }
}
