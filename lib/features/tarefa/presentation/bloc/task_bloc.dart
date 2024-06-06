import 'dart:async';

import 'package:bloc_project/features/tarefa/domain/entitites/task.dart';
import 'package:bloc_project/features/tarefa/domain/entitites/task_repo.dart';
import 'package:bloc_project/features/tarefa/presentation/bloc/task_event.dart';
import 'package:bloc_project/features/tarefa/presentation/bloc/task_state.dart';

class TaskBloc {
  final TaskRepo _taskRepo = TaskRepo();

  final StreamController<TaskEvent> _inputTaskController =
      StreamController<TaskEvent>();
  final StreamController<TaskState> _outputTaskController =
      StreamController<TaskState>();

  Sink<TaskEvent> get inputTask => _inputTaskController.sink;
  Stream<TaskState> get outputTask => _outputTaskController.stream;

  TaskBloc() {
    _inputTaskController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(TaskEvent event) async {
    List<Task> tasks = [];
    _outputTaskController.add(TaskLoadingState());

    if (event is GetTasks) {
      tasks = await _taskRepo.getTasks();
    } else if (event is PostTask) {
      tasks = await _taskRepo.postTask(task: event.task);
    } else if (event is DeleteTasks) {
      tasks = await _taskRepo.deleteTask(task: event.task);
    }

    _outputTaskController.add(TaskLoadedState(tasks));
  }
}
