import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_flutter/providers/todo_list_manager.dart';
import 'package:uuid/uuid.dart';

import '../models/todo_model.dart';

final todoListProvider =
    StateNotifierProvider<TodoListManager, List<TodoModel>>(((ref) {
  return TodoListManager([
    TodoModel(id: Uuid().v4(), description: 'Spora Git'),
    TodoModel(id: Uuid().v4(), description: 'Ders Çalış'),
    TodoModel(id: Uuid().v4(), description: 'Alışveriş'),
  ]);
}));
