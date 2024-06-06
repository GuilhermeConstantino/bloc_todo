import 'package:bloc_project/features/tarefa/domain/entitites/task.dart';
import 'package:flutter/material.dart';

@immutable
sealed class TaskState {
  final List<Task> tasks;

  const TaskState(this.tasks);
}

class TaskInitialState extends TaskState {
  TaskInitialState() : super([]);
}

class TaskLoadingState extends TaskState {
  TaskLoadingState() : super([]);
}

class TaskLoadedState extends TaskState {
  const TaskLoadedState(super.tasks);
}

class TaskErrorState extends TaskState {
  final Exception exception;
  TaskErrorState(this.exception) : super([]);
}
