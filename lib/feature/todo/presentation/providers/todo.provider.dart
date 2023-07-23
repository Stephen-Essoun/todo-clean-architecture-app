import 'package:flutter/material.dart';
import 'package:todo/feature/todo/domain/usecases/add.dart';
import 'package:todo/feature/todo/shared/utils/usecases.dart';

import '../../domain/entities/todo.dart';

class TodoProvider extends ChangeNotifier {
  final AddTodo addTodo;

  TodoProvider(this.addTodo);
   TodoProvider.empty():addTodo = AddTodo.empty();

  add(BuildContext context) async {
    final result = await addTodo
        .call(Params(Todo(id: '1', text: 'text', description: 'description')));
    result.fold(
      (l) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('failure'),
        ));
      },
      (r) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('success'),
        ));
      },
    );
  }
}
