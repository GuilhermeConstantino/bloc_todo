import 'package:bloc_project/features/tarefa/domain/entitites/task.dart';
import 'package:bloc_project/features/tarefa/presentation/bloc/task_bloc.dart';
import 'package:bloc_project/features/tarefa/presentation/bloc/task_event.dart';
import 'package:bloc_project/features/tarefa/presentation/bloc/task_state.dart';
import 'package:flutter/material.dart';

class TaskPage extends StatelessWidget {
  TaskPage({super.key});

  static const String pageTitle = 'BLoC pattern';
  static const String errorMsg = 'Erro';
  final TaskBloc taskBloc = TaskBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text(pageTitle)),
      ),
      body: StreamBuilder<TaskState>(
          stream: taskBloc.outputTask,
          builder: (context, state) {
            if (state.data is TaskLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.data is TaskLoadedState) {
              final List<Task> tasks = state.data?.tasks ?? [];
              return ListView.separated(
                separatorBuilder: (_, __) => const Divider(),
                itemCount: tasks.length,
                itemBuilder: (_, index) {
                  Task task = tasks[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Center(
                        child: Text(index.toString()),
                      ),
                    ),
                    title: Text(task.name),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () => _deleteTask(task),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: const Text(errorMsg));
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTask(Task(name: 'Task exemplor')),
        child: const Icon(Icons.abc),
      ),
    );
  }

  _deleteTask(Task task) {
    taskBloc.inputTask.add(DeleteTasks(task));
  }

  _addTask(Task task) {
    print('object');
    taskBloc.inputTask.add(PostTask(task));
  }
}
