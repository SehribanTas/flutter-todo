import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../models/todo_model.dart';

class TodoListManager extends StateNotifier<List<TodoModel>> {
  TodoListManager([List<TodoModel>? initialTodos]) : super(initialTodos ?? []);
  void addTodo(String description) {
    var newTodo = TodoModel(id: Uuid().v4(), description: description);
    state = [...state, newTodo];
  }

  void toggle(String id) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(
              id: id, description: todo.description, completed: !todo.completed)
        else
          todo,
    ];
  }

  void edit({required String id, required String newDescription}) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(
              id: id, description: newDescription, completed: todo.completed)
        else
          todo,
    ];
  }

  void remover(TodoModel todoWillBeDeleted) {
    state =
        state.where((element) => element.id != todoWillBeDeleted.id).toList();
  }

  int oncompletedTodoCount() {
    return state.where((element) => !element.completed).length;
  }

  void filtre(String filtreKey) {
   
    switch (filtreKey) {
      case 'All':
        state = state;
        break;
      case 'Active':
        state = state.where((element) => !element.completed).toList();
        break;
      case 'Completed':
        state = state.where((element) => element.completed).toList();
        break;
    }
  }
}
