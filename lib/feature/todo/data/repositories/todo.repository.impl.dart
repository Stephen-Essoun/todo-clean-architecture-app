import 'package:dartz/dartz.dart';
import 'package:todo/feature/todo/data/database/remote.db.dart';
import 'package:todo/feature/todo/domain/entities/todo.dart';
import 'package:todo/feature/todo/domain/repositories/todo.repository.dart';
import 'package:todo/feature/todo/shared/errors/failure.dart';

class TodoRepositoryImpl implements TodoRepository{
  final TodoRemoteDB remoteDB;
  TodoRepositoryImpl(this.remoteDB);

  @override
  Future<Either<Failure, Todo>> add(Todo todo) async{
    try {
      final result = await remoteDB.addTodo(todo);
      return Right(result);
    } catch (e) {
      return Left(Failure("Oops, creating was unsuccessful"));
    }
  }

  @override
  Future<Either<Failure, Todo>> delete(Todo todo)async {
    try {
      final result = await remoteDB.deleteTodo(todo);
      return Right(result);
    } catch (e) {
      return Left(Failure("Oops, deleting was unsuccessful"));
    }
  }

  @override
  Future<Either<Failure, Todo>> edit(Todo todo)async {
    try {
      final result = await remoteDB.editTodo(todo);
      return Right(result);
    } catch (e) {
      return Left(Failure("Oops, editing was unsuccessful"));
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> getAll() async{
    try {
      final result = await remoteDB.listTodos();
      return Right(result);
    } catch (e) {
      return Left(Failure("Oops, creating was unsuccessful"));
    }
  }
  

  
}