import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:todo/feature/todo/data/repositories/todo.repository.impl.dart';

import '../../shared/errors/failure.dart';
import '../../shared/utils/usecases.dart';
import '../entities/todo.dart';
import '../repositories/todo.repository.dart';

class DeleteTodo extends ChangeNotifier implements UseCase<Todo,Params<Todo>> {
  final TodoRepository repo;

  DeleteTodo(this.repo);
  DeleteTodo.empty():repo = TodoRepositoryImpl.empty();
  @override
  Future<Either<Failure, Todo>> call(Params todo)async {
    return await repo.delete(todo.data);
  }
}
