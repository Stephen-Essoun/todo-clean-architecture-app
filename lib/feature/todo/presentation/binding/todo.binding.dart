import 'package:provider/provider.dart';
import 'package:todo/feature/todo/data/database/remote.db.dart';
import 'package:todo/feature/todo/data/repositories/todo.repository.impl.dart';
import 'package:todo/feature/todo/domain/repositories/todo.repository.dart';
import 'package:todo/feature/todo/domain/usecases/add.dart';
import 'package:todo/feature/todo/domain/usecases/delete.dart';
import 'package:todo/feature/todo/domain/usecases/get.all.dart';
import 'package:todo/feature/todo/presentation/providers/todo.provider.dart';

class TodoBinding {
  // Create a provider for TodoRemoteDBImpl
   final todoReDB = ChangeNotifierProvider<TodoRemoteDBImpl>(
    create: (context) => TodoRemoteDBImpl(),
  );

  // Create a provider for TodoRepositoryImpl and inject TodoRemoteDBImpl
   final todoRepo = ChangeNotifierProxyProvider<TodoRemoteDBImpl, TodoRepository>(
    create: (_) => TodoRepositoryImpl.empty(),
    update: (context, remoteDB, todoRepo) {
      return TodoRepositoryImpl( remoteDB);
    },
  );

  // Create a provider for AddTodo and inject TodoRepository
   final addTodo = ChangeNotifierProxyProvider<TodoRepository, AddTodo>(
    create: (_) => AddTodo.empty(),//there is one positional argument expected here too
    update: (context, repository, addTodo) {
      return AddTodo(repository);
    },
  );

  final getAllTodo = ChangeNotifierProxyProvider<TodoRepository,GetAllTodo>(create: (_) => GetAllTodo.empty(),update: (context, value, previous) {
    return GetAllTodo(value);
  },);

  final deletTodo = ChangeNotifierProxyProvider<TodoRepository,DeleteTodo> (create: (context) => DeleteTodo.empty(),update: (context, value, previous) => DeleteTodo(value),);

   final todoPro = ChangeNotifierProxyProvider<AddTodo, TodoProvider>(
    create: (_) => TodoProvider.empty(),//there is one positional argument expected here too
    update: (context, addTodo, todoPro) {
      return TodoProvider(addTodo,context.read<GetAllTodo>(),context.read<DeleteTodo>());
    },
  );
}
