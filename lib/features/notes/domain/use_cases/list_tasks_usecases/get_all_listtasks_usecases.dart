import 'package:sakinah/features/notes/domain/entities/list_tasks.dart';
import 'package:sakinah/features/notes/domain/repository/notes_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:sakinah/core/errors/failure.dart';

class GetAllListtasksUsecases {
  final NotesRepository repository;
  GetAllListtasksUsecases(this.repository);

  Future<Either<Failure, List<ListTasks>>> call() async {
    return await repository.getAllListTasks();
  }
}
