import 'package:bloc_project/features/tarefa/domain/entitites/task.dart';

class TaskRepo {
  final List<Task> _tasks = [];

  Future<List<Task>> getTasks() async {
    _tasks.addAll([
      Task(name: 'Compras no mercado'),
      Task(name: 'Fazer exercícios'),
      Task(name: 'Buscar filhos na escola'),
      Task(name: 'Jogar vídeo game'),
    ]);

    return Future.delayed(const Duration(seconds: 2), () => _tasks);
  }

  Future<List<Task>> postTask({required Task task}) async {
    _tasks.add(task);

    return Future.delayed(const Duration(seconds: 2), () => _tasks);
  }

  Future<List<Task>> deleteTask({required Task task}) async {
    _tasks.remove(task);

    return Future.delayed(const Duration(seconds: 2), () => _tasks);
  }
}
