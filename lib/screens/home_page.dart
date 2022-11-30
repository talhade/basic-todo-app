import 'package:basic_todo_app/models/todo.dart';
import 'package:basic_todo_app/riverpod/todo_provider.dart';
import 'package:basic_todo_app/screens/statistics_page.dart';
import 'package:basic_todo_app/widgets/add_todo_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

final todoNotifierProvider = ChangeNotifierProvider<TodoNotifier>((ref) {
  return TodoNotifier();
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController titleController = TextEditingController();
    TextEditingController subtitleController = TextEditingController();
    List<Todo> toDos = ref.watch(todoNotifierProvider).todoList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo App'),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const StatisticsPage(),
                  )),
              icon: const Icon(Icons.bar_chart))
        ],
      ),
      body: ref.read(todoNotifierProvider.notifier).length == 0
          ? const Center(
              child: Text('You Dont Have Any Todo\'s'),
            )
          : Consumer(
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
                          return todoCard(todo, ref, context,
                              subtitleController, titleController);
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
              final todos = ref.read(todoNotifierProvider);
              todos.addTodo(todo);
            }
          },
          child: const Icon(Icons.add)),
    );
  }
}

Card todoCard(
    Todo todo,
    WidgetRef ref,
    BuildContext context,
    TextEditingController titleController,
    TextEditingController subtitleController) {
  return Card(
    child: Slidable(
      direction: Axis.horizontal,
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.red,
            onPressed: (context) {
              ref.read(todoNotifierProvider).removeTodo(todo);
            },
            icon: Icons.delete,
          )
        ],
      ),
      child: ListTile(
        title: Text(todo.title),
        subtitle: Text(todo.subtitle),
        trailing: IconButton(
          onPressed: () async {
            final updatedTodo = await todoDialog(
                context, titleController, subtitleController, todo);
            if (updatedTodo != null) {
              ref.read(todoNotifierProvider.notifier).update(updatedTodo);
            }
          },
          icon: const Icon(Icons.edit),
        ),
        leading: Checkbox(
          value: todo.isChecked,
          onChanged: (value) {
            return ref.read(todoNotifierProvider.notifier).checkTodo(todo);
          },
        ),
      ),
    ),
  );
}
