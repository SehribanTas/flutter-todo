import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_flutter/providers/todo_list_manager.dart';
import 'package:uuid/uuid.dart';

import '../models/todo_model.dart';

enum TodoListFilter { all, active, completed }

final todoListFilter = StateProvider<TodoListFilter>(((ref) {
  return TodoListFilter.all;
}));

final todoListProvider =
    StateNotifierProvider<TodoListManager, List<TodoModel>>(((ref) {
  return TodoListManager([
    TodoModel(id: Uuid().v4(), description: 'Spora Git'),
    TodoModel(id: Uuid().v4(), description: 'Ders Çalış'),
    TodoModel(id: Uuid().v4(), description: 'Alışveriş'),
  ]);
}));

final filteredTodoList = Provider<List<TodoModel>>(
  (ref) {
    final filter = ref.watch(todoListFilter);
    final List<TodoModel> todoList = ref.watch(todoListProvider);

    switch (filter) {
      case TodoListFilter.all:
        return todoList;

      case TodoListFilter.active:
        return todoList.where((element) => !element.completed).toList();

      case TodoListFilter.completed:
        return todoList.where((element) => element.completed).toList();
    }
  },
);
