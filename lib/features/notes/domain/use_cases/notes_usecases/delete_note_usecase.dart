import 'package:dartz/dartz.dart';
import 'package:sakinah/core/errors/failure.dart';
import 'package:sakinah/features/notes/domain/repository/notes_repository.dart';

class DeleteNoteUsecase {
  final NotesRepository repository;
  DeleteNoteUsecase(this.repository);

  Future<Either<Failure, Unit>> call(int id) async {
    return await repository.deleteNote(id);
  }
}
