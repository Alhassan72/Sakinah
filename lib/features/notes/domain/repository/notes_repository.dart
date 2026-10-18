import 'package:dartz/dartz.dart';
import 'package:sakinah/core/errors/failure.dart';
import 'package:sakinah/features/notes/domain/entities/list_tasks.dart';
import 'package:sakinah/features/notes/domain/entities/note.dart';

abstract class NotesRepository {
  // Note
  Future<Either<Failure, List<Note>>> getAllNotes();
  Future<Either<Failure, Unit>> addNote(Note note);
  Future<Either<Failure, Unit>> updateNote(Note note);
  Future<Either<Failure, Unit>> deleteNote(int id);

  // List Tasks
  Future<Either<Failure, List<ListTasks>>> getAllListTasks();
  Future<Either<Failure, Unit>> addListTasks(ListTasks listTasks);
  Future<Either<Failure, Unit>> updateListTasks(ListTasks listTasks);
  Future<Either<Failure, Unit>> deleteListTasks(String id);
}
