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
    TextEditingController titleController = TextEditingController();
    TextEditingController subtitleController = TextEditingController();
    List<Todo> toDos = ref.watch(TodoNotifierProvider).todoList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo App'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          return Column(
            children: [
              Text(
                'Your Todos: ',
                style: Theme.of(context).textTheme.headline3,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: toDos.length,
                  itemBuilder: (context, index) {
                    final todo = toDos[index];
                    return todoCard(todo, ref);
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final todo =
                await todoDialog(context, titleController, subtitleController);
            if (todo != null) {
              final todos = ref.read(TodoNotifierProvider);
              todos.addTodo(todo);
            }
          },
          child: const Icon(Icons.add)),
    );
  }
}

Card todoCard(Todo todo, WidgetRef ref) {
  return Card(
    child: ListTile(
      title: Text(todo.title),
      subtitle: Text(todo.subtitle),
      leading: Checkbox(
        value: todo.isChecked,
        onChanged: (value) {
          return ref.read(TodoNotifierProvider.notifier).checkTodo(todo);
        },
      ),
    ),
  );
}

Future<Todo?> todoDialog(
    BuildContext context,
    TextEditingController titleController,
    TextEditingController subtitleController,
    [Todo? existingTodo]) {
  String? title = existingTodo?.title;
  String? subtitle = existingTodo?.subtitle;

  titleController.text = title ?? '';
  subtitleController.text = subtitle ?? '';

  return showDialog<Todo?>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Center(child: Text('TODO🖋')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Enter Your Todo:'),
              onChanged: (value) {
                title = value;
              },
            ),
            TextField(
              controller: subtitleController,
              decoration: const InputDecoration(labelText: 'Enter Description'),
              onChanged: (value) {
                subtitle = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
              onPressed: () {
                //if we have todo:
                if (title != null && subtitle != null) {
                  //the todo we have is existing so we are updating:
                  if (existingTodo != null) {
                    final newTodo = existingTodo.update(title, subtitle);
                    Navigator.of(context).pop(newTodo);
                  }
                  //the todo we have is not existing so we are creating new
                  else {
                    final newTodo = Todo(title: title!, subtitle: subtitle!);
                    Navigator.of(context).pop(newTodo);
                  }
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text('Done'),
                  Icon(Icons.check),
                ],
              ))
        ],
      );
    },
  );
}
