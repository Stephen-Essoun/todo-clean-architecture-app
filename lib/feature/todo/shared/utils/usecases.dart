import 'package:dartz/dartz.dart';

import '../../domain/entities/todo.dart';
import '../errors/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Todo>> call(Params params);
}
