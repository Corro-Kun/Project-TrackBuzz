import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackbuzz/features/task/domain/usecase/delete_task_use_case.dart';
import 'package:trackbuzz/features/task/domain/usecase/get_list_task_use_case.dart';
import 'package:trackbuzz/features/task/presentation/bloc/Task/task_event.dart';
import 'package:trackbuzz/features/task/presentation/bloc/Task/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetListTaskUseCase getListTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;

  TaskBloc({required this.getListTaskUseCase, required this.deleteTaskUseCase})
    : super(TaskInitial()) {
    on<GetTasks>(_onGetTasks);
    on<DeleteTask>(_onDeleteTask);
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

  Future<void> _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    final currentState = state as TaskLoaded;
    final int id = currentState.tasks[event.index].id;
    try {
      currentState.tasks.removeAt(event.index);
      emit(TaskLoaded(tasks: currentState.tasks));
      await deleteTaskUseCase.execute(id);
    } catch (e) {
      emit(TaskError(message: e.toString()));
    }
  }
}
