import 'package:dartz/dartz.dart';
import 'package:sakinah/core/errors/exception.dart';
import 'package:sakinah/core/errors/failure.dart';
import 'package:sakinah/features/notes/data/data_sources/notes_local_data_source.dart';
import 'package:sakinah/features/notes/data/models/list_tasks_model.dart';
import 'package:sakinah/features/notes/data/models/note_model.dart';
import 'package:sakinah/features/notes/domain/entities/list_tasks.dart';
import 'package:sakinah/features/notes/domain/entities/note.dart';
import 'package:sakinah/features/notes/domain/repository/notes_repository.dart';

class NotesRepositoryImpl implements NotesRepository {
  final NotesLocalDataSource notesLocalDataSource;

  NotesRepositoryImpl(this.notesLocalDataSource);

  // notes
  @override
  Future<Either<Failure, List<Note>>> getAllNotes() async {
    try {
      final notes = await notesLocalDataSource.getAllNotes();
      return Right(notes);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addNote(Note note) async {
    try {
      final noteModel = NoteModel(
        id: note.id,
        title: note.title,
        content: note.content,
        createdAt: note.createdAt,
      );
      await notesLocalDataSource.addNote(noteModel);
      return Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateNote(Note note) async {
    try {
      final noteModel = NoteModel(
        id: note.id,
        title: note.title,
        content: note.content,
        createdAt: note.createdAt,
      );
      await notesLocalDataSource.updateNote(noteModel);
      return Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteNote(int id) async {
    try {
      await notesLocalDataSource.deleteNote(id);
      return Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  // list tasks
  @override
  Future<Either<Failure, List<ListTasks>>> getAllListTasks() async {
    try {
      final listTasks = await notesLocalDataSource.getAllListTasks();
      return Right(listTasks);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addListTasks(ListTasks listTasks) async {
    try {
      final listTask = ListTasksModel(
        id: listTasks.id,
        title: listTasks.title,
        task: listTasks.task,
        order: listTasks.order,
        isDone: listTasks.isDone,
        date: listTasks.date,
      );
      await notesLocalDataSource.addListTasks(listTask);
      return Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateListTasks(ListTasks listTasks) async {
    try {
      final listTask = ListTasksModel(
        id: listTasks.id,
        title: listTasks.title,
        task: listTasks.task,
        isDone: listTasks.isDone,
        order: listTasks.order,
        date: listTasks.date,
      );
      await notesLocalDataSource.updateListTasks(listTask);
      return Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteListTasks(String id) async {
    try {
      await notesLocalDataSource.deleteListTasks(id);
      return Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
