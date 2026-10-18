import 'package:dartz/dartz.dart';
import 'package:sakinah/core/errors/failure.dart';
import 'package:sakinah/features/tasks/domain/repository/tasks_repository.dart';

class UpdateTimeTaskUsecase {
  final TasksRepository repository;

  UpdateTimeTaskUsecase(this.repository);

  Future<Either<Failure, Unit>> call(Task task) =>
      repository.updateTimeTask(task);
}
