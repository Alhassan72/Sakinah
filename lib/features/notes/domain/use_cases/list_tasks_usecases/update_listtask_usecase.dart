import 'package:sakinah/features/notes/domain/entities/list_tasks.dart';
import 'package:sakinah/features/notes/domain/repository/notes_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:sakinah/core/errors/failure.dart';

class UpdateListtaskUsecase {
  final NotesRepository repository;
  UpdateListtaskUsecase(this.repository);

  Future<Either<Failure, Unit>> call(ListTasks listTasks) async {
    return await repository.updateListTasks(listTasks);
  }
}
