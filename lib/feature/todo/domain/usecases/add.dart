import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:todo/feature/todo/data/repositories/todo.repository.impl.dart';

import 'package:todo/feature/todo/domain/entities/todo.dart';
import 'package:todo/feature/todo/domain/repositories/todo.repository.dart';

import 'package:todo/feature/todo/shared/errors/failure.dart';

import '../../shared/utils/usecases.dart';

class AddTodo extends ChangeNotifier implements UseCase<Todo,Params<Todo>> {
  final TodoRepository repo;

  AddTodo(this.repo);
  AddTodo.empty():repo = TodoRepositoryImpl.empty();
  @override
  Future<Either<Failure, Todo>> call(Params todo)async {
    return await repo.add(todo.data);
  }
}
