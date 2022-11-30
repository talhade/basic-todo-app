import 'package:basic_todo_app/models/todo.dart';
import 'package:flutter/material.dart';

class TodoNotifier extends ChangeNotifier {
  final todoList = <Todo>[];

  void addTodo(Todo todo) {
    todoList.add(todo);
    notifyListeners();
  }

  void removeTodo(Todo todo) {
    todoList.remove(todo);
    notifyListeners();
  }

  void checkTodo(Todo todo) {
    for (final i in todoList) {
      if (i.id == todo.id) {
        i.isChecked = !i.isChecked;
        notifyListeners();
      }
    }
  }
}
