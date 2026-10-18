import 'package:sakinah/features/notes/domain/repository/notes_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:sakinah/core/errors/failure.dart';

class DeleteListtaskUsecase {
  final NotesRepository repository;
  DeleteListtaskUsecase(this.repository);

  Future<Either<Failure, Unit>> call(String id) async {
    return await repository.deleteListTasks(id);
  }
}
