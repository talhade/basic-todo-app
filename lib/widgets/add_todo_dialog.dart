import 'package:basic_todo_app/models/todo.dart';
import 'package:flutter/material.dart';

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
              decoration:
                  const InputDecoration(labelText: 'Enter Description:'),
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
