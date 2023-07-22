import 'package:dartz/dartz.dart';

import '../../shared/errors/failure.dart';
import '../../shared/utils/usecases.dart';
import '../entities/todo.dart';
import '../repositories/todo.repository.dart';

class DeleteTodo implements UseCase<Todo,Params<Todo>> {
  final TodoRepository repo;

  DeleteTodo(this.repo);
  @override
  Future<Either<Failure, Todo>> call(Params todo)async {
    return await repo.delete(todo.data);
  }
}
