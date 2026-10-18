import 'package:dartz/dartz.dart';
import 'package:sakinah/core/errors/failure.dart';

abstract class TasksRepository {
  Future<Either<Failure, List<Task>>> getAllTasks();
  Future<Either<Failure, Unit>> updateTimeTask(Task task);
}
