import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:todo/feature/todo/data/repositories/todo.repository.impl.dart';

import '../../shared/errors/failure.dart';
import '../../shared/utils/usecases.dart';
import '../entities/todo.dart';
import '../repositories/todo.repository.dart';

class EditTodo extends ChangeNotifier implements UseCase<Todo,Params<Todo>> {
  final TodoRepository repo;

  EditTodo(this.repo);
  EditTodo.empty():repo = TodoRepositoryImpl.empty();
  @override
  Future<Either<Failure, Todo>> call(Params todo)async {
    return await repo.edit(todo.data);
  }
}
