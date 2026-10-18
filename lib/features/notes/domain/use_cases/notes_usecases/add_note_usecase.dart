import 'package:dartz/dartz.dart';
import 'package:sakinah/core/errors/failure.dart';
import 'package:sakinah/features/notes/domain/entities/note.dart';
import 'package:sakinah/features/notes/domain/repository/notes_repository.dart';

class AddNoteUsecase {
  final NotesRepository repository;
  AddNoteUsecase(this.repository);
  Future<Either<Failure, Unit>> call(Note note) async {
    return await repository.addNote(note);
  }
}
