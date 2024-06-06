import 'package:bloc/bloc.dart';
import 'package:bloc_project/features/tarefa/domain/entitites/task.dart';
import 'package:bloc_project/features/tarefa/domain/entitites/task_repo.dart';
import 'package:bloc_project/features/tarefa/presentation/bloc/task_event.dart';
import 'package:bloc_project/features/tarefa/presentation/bloc/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepo _taskRepo = TaskRepo();

  TaskBloc() : super(TaskInitialState()) {
    on(_mapEventToState);
  }

  void _mapEventToState(TaskEvent event, Emitter<TaskState> emit) async {
    List<Task> tasks = [];

    emit(TaskLoadingState());
    if (event is GetTasks) {
      tasks = await _taskRepo.getTasks();
    } else if (event is PostTask) {
      tasks = await _taskRepo.postTask(task: event.task);
    } else if (event is DeleteTasks) {
      tasks = await _taskRepo.deleteTask(task: event.task);
    }
    emit(TaskLoadedState(tasks));
  }
}
