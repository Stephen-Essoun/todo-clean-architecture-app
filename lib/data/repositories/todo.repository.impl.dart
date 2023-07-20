import 'package:todo/domain/entities/todo.dart';
import 'package:todo/domain/repositories/todo.repository.dart';

class TodoRepositoryImpl implements TodoRepository{
  @override
  Future<Todo> add(Todo todo) async{
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<Todo> edit(Todo todo)async {
    // TODO: implement edit
    throw UnimplementedError();
  }

  @override
  Future<Todo> delete(Todo todo)async {
    // TODO: implement save
    throw UnimplementedError();
  }
  @override
  Future<List<Todo>> getAll()async {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  
}