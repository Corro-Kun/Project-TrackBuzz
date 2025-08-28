import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackbuzz/features/task/domain/usecase/get_list_task_use_case.dart';
import 'package:trackbuzz/features/task/presentation/bloc/Task/task_event.dart';
import 'package:trackbuzz/features/task/presentation/bloc/Task/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetListTaskUseCase getListTaskUseCase;

  TaskBloc({required this.getListTaskUseCase}) : super(TaskInitial()) {
    on<GetTasks>(_onGetTasks);
  }

  Future<void> _onGetTasks(GetTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final tasks = await getListTaskUseCase.execute(event.id);
      emit(TaskLoaded(tasks: tasks));
    } catch (e) {
      emit(TaskError(message: e.toString()));
    }
  }
}
