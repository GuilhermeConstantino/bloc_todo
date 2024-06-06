import 'package:bloc_project/features/tarefa/domain/entitites/task.dart';
import 'package:flutter/material.dart';

@immutable
sealed class TaskEvent {}

class GetTasks extends TaskEvent {}

class PostTask extends TaskEvent {
  final Task task;

  PostTask(this.task);
}

class DeleteTasks extends TaskEvent {
  final Task task;

  DeleteTasks(this.task);
}
