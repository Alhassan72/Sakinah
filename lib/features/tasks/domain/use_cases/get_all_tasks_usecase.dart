import 'package:dartz/dartz.dart';
import 'package:sakinah/core/errors/failure.dart';
import 'package:sakinah/features/tasks/domain/repository/tasks_repository.dart';

class GetAllTasksUsecase {
  final TasksRepository repository;
  GetAllTasksUsecase(this.repository);

  Future<Either<Failure, List<Task>>> call() => repository.getAllTasks();
}
