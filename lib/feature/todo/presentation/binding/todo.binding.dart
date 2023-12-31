import 'package:provider/provider.dart';
import 'package:todo/feature/todo/data/database/remote.db.dart';
import 'package:todo/feature/todo/data/repositories/todo.repository.impl.dart';
import 'package:todo/feature/todo/domain/repositories/todo.repository.dart';
import 'package:todo/feature/todo/domain/usecases/add.dart';
import 'package:todo/feature/todo/domain/usecases/delete.dart';
import 'package:todo/feature/todo/domain/usecases/edit.dart';
import 'package:todo/feature/todo/domain/usecases/get.all.dart';
import 'package:todo/feature/todo/presentation/providers/todo.provider.dart';

class TodoBinding {
  final todoReDB = ChangeNotifierProvider<TodoRemoteDBImpl>(
    create: (context) => TodoRemoteDBImpl(),
  );

  final todoRepo =
      ChangeNotifierProxyProvider<TodoRemoteDBImpl, TodoRepository>(
    create: (_) => TodoRepositoryImpl.empty(),
    update: (context, remoteDB, todoRepo) {
      return TodoRepositoryImpl(remoteDB);
    },
  );

  final addTodo = ChangeNotifierProxyProvider<TodoRepository, AddTodo>(
    create: (_) => AddTodo.empty(),
    update: (context, repository, addTodo) {
      return AddTodo(repository);
    },
  );

  final getAllTodo = ChangeNotifierProxyProvider<TodoRepository, GetAllTodo>(
    create: (_) => GetAllTodo.empty(),
    update: (context, repository, previous) {
      return GetAllTodo(repository);
    },
  );

  final deletTodo = ChangeNotifierProxyProvider<TodoRepository, DeleteTodo>(
    create: (context) => DeleteTodo.empty(),
    update: (context, value, previous) => DeleteTodo(value),
  );

  final editTodo = ChangeNotifierProxyProvider<TodoRepository, EditTodo>(
    create: (context) => EditTodo.empty(),
    update: (context, repository, editTodo) => EditTodo(repository),
  );

  final todoPro = ChangeNotifierProxyProvider<AddTodo, TodoProvider>(
    create: (_) => TodoProvider.empty(),
    update: (context, addTodo, todoPro) {
      
      return TodoProvider(addTodo, context.read<GetAllTodo>(),
          context.read<DeleteTodo>(), context.read<EditTodo>());
    },
  );
}
