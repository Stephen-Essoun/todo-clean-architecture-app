import 'package:flutter/material.dart';
import 'package:todo/feature/todo/domain/usecases/add.dart';
import 'package:todo/feature/todo/domain/usecases/edit.dart';
import 'package:todo/feature/todo/domain/usecases/get.all.dart';
import 'package:todo/feature/todo/shared/utils/usecases.dart';

import '../../domain/entities/todo.dart';
import '../../domain/usecases/delete.dart';

class TodoProvider extends ChangeNotifier {
  final AddTodo addTodo;
  final GetAllTodo getAllTodo;
  final DeleteTodo deleteTodo;
  final EditTodo editTodo;

  TodoProvider(this.addTodo, this.getAllTodo, this.deleteTodo, this.editTodo);
  TodoProvider.empty()
      : addTodo = AddTodo.empty(),
        getAllTodo = GetAllTodo.empty(),
        deleteTodo = DeleteTodo.empty(),
        editTodo = EditTodo.empty();

  Future<void> add(BuildContext context, Todo todo) async {
    final result = await addTodo.call(Params(todo));
    result.fold(
      (l) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('failure'),
        ));
      },
      (success) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Todo added successfully'),
        ));
        Navigator.of(context).pop();
        return success;
      },
    );
  }

  Future<void> delete(Todo todo, BuildContext context) async {
    final result = await deleteTodo.call(Params(todo));
    result.fold(
      (failure) => print(failure.message),
      (success) => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Todo deleted successfully'),
      )),
    );
  }

  Future<void> edit(Todo todo, BuildContext context) async {
    final result = await editTodo.call(Params(todo));
    result.fold((failure) {
      print(failure.message);
    }, (success) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Todo editted successfully'),
      ));      Navigator.of(context).pop();

      return success;
    });
  }

  Stream<List<Todo>> listTodo(BuildContext context) async* {
    final result = await getAllTodo.call(Params(NoParams));
    yield* result.fold((failure) {
      print(failure.message);
      return Stream.value([]);
    }, (success) => success);
  }
}
