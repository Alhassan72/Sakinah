import 'package:sakinah/features/notes/domain/repository/notes_repository.dart';

import 'package:dartz/dartz.dart';
import 'package:sakinah/core/errors/failure.dart';
import 'package:sakinah/features/notes/domain/entities/note.dart';

class GetAllNotes {
  final NotesRepository repository;
  GetAllNotes(this.repository);

  Future<Either<Failure, List<Note>>> call() async {
    return await repository.getAllNotes();
  }
}
