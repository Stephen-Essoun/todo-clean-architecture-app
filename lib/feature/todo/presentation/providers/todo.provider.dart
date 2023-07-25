import 'package:flutter/material.dart';
import 'package:todo/feature/todo/domain/usecases/add.dart';
import 'package:todo/feature/todo/domain/usecases/get.all.dart';
import 'package:todo/feature/todo/shared/utils/usecases.dart';

import '../../domain/entities/todo.dart';
import '../../domain/usecases/delete.dart';

class TodoProvider extends ChangeNotifier {
  final AddTodo addTodo;
  final GetAllTodo getAllTodo;
  final DeleteTodo deleteTodo;

  TodoProvider(this.addTodo, this.getAllTodo, this.deleteTodo);
  TodoProvider.empty()
      : addTodo = AddTodo.empty(),
        getAllTodo = GetAllTodo.empty(),
        deleteTodo = DeleteTodo.empty();


  add(BuildContext context,Todo todo) async {
    final result = await addTodo
        .call(Params(todo));
    result.fold(
      (l) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('failure'),
        ));
      },
      (success) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('success'),
        ));
        Navigator.of(context).pop();
        return success;
      },
    );
  }

  delete()async{
final result = await deleteTodo.call(Params(Todo));
  }

  Stream<List<Todo>> listTodo(BuildContext context) async* {
    final result = await getAllTodo.call(Params(NoParams));
    yield* result.fold((failure) {
      print(failure.message);
      return Stream.value([]);
    }, (success) => success);
  }
}
