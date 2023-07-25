import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:todo/feature/todo/data/repositories/todo.repository.impl.dart';

import '../../shared/errors/failure.dart';
import '../../shared/utils/usecases.dart';
import '../entities/todo.dart';
import '../repositories/todo.repository.dart';

class GetAllTodo extends ChangeNotifier implements UseCase< Stream<List<Todo>>, Params<void>> {
  final TodoRepository repo;

  GetAllTodo(this.repo);
  GetAllTodo.empty():repo=TodoRepositoryImpl.empty();

  @override
  Future<Either<Failure, Stream<List<Todo>>>> call(Params params) {
    return repo.getAll();
  }

  
}
