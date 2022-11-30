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

  void update(Todo existingTodo) {
    final index = todoList.indexOf(existingTodo);
    final oldTodo = todoList[index];
    if (oldTodo.title != existingTodo.title ||
        oldTodo.subtitle != existingTodo.subtitle) {
      todoList[index] =
          oldTodo.update(existingTodo.title, existingTodo.subtitle);
    }
    notifyListeners();
  }

  int get length {
    return todoList.length;
  }

  int get checkedTodos {
    int length = 0;
    for (final i in todoList) {
      if (i.isChecked == true) {
        length += 1;
      }
    }
    return length;
  }
}
