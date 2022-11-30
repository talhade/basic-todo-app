import 'package:basic_todo_app/models/todo.dart';
import 'package:basic_todo_app/riverpod/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final TodoNotifierProvider = ChangeNotifierProvider<TodoNotifier>((ref) {
  return TodoNotifier();
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> toDos = ref.watch(TodoNotifierProvider).todoList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo App'),
      ),
      body: Column(
        children: [
          Text(
            'Your Todos: ',
            style: Theme.of(context).textTheme.headline3,
          ),
          ListView.builder(
            itemCount: toDos.length,
            itemBuilder: (context, index) {
              final todo = toDos[index];
              return todoCard(todo);
            },
          ),
        ],
      ),
    );
  }
}

Card todoCard(Todo todo) {
  return Card(
    child: ListTile(
      title: Text(todo.title),
      subtitle: Text(todo.subtitle),
      // trailing: Checkbox(value: value, onChanged: onChanged),
    ),
  );
}
