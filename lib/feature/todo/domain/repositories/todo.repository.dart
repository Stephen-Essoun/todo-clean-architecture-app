import 'package:dartz/dartz.dart';
import 'package:todo/feature/todo/shared/errors/failure.dart';

import '../entities/todo.dart';

abstract class TodoRepository {
  Future<Either<Failure,Todo>> add(Todo todo);
  Future<Either<Failure,Todo>> edit(Todo todo);
  Future<Either<Failure,Todo>> delete(Todo todo);
  Future<Either<Failure,List<Todo>>> getAll();
}
