import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/todo.dart';

abstract class TodoRemoteDB extends ChangeNotifier {
  Future<Todo> addTodo(Todo todo);
  Future<Todo> editTodo(Todo todo);
  Future<Todo> deleteTodo(Todo todo);
  Future<List<Todo>> listTodos();
}

class TodoRemoteDBImpl extends ChangeNotifier implements TodoRemoteDB {
  // static empty() {}

  final db = FirebaseFirestore.instance.collection('todo');

  @override
  Future<Todo> addTodo(Todo todo) async {
    await db.doc(todo.id).set(todo.toMap());
    return todo;
  }

  @override
  Future<Todo> editTodo(Todo todo) async {
    await db.doc(todo.id).update(todo.toMap());
    return todo;
  }

  @override
  Future<Todo> deleteTodo(Todo todo) async {
    await db.doc(todo.id).delete();
    return todo;
  }

  @override
  Future<List<Todo>> listTodos() async {
    final todos = await db.get();
    return todos.docs
        .map(
          (todo) => Todo.fromMap(todo.data()),
        )
        .toList();
  }
}
