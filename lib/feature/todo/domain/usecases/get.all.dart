import 'package:dartz/dartz.dart';

import '../../shared/errors/failure.dart';
import '../../shared/utils/usecases.dart';
import '../entities/todo.dart';
import '../repositories/todo.repository.dart';

class GetAllTodo implements UseCase<List<Todo>, Params<void>> {
  final TodoRepository repo;

  GetAllTodo(this.repo);

  @override
  Future<Either<Failure, List<Todo>>> call(Params<void> params) {
    return repo.getAll();
  }
}
