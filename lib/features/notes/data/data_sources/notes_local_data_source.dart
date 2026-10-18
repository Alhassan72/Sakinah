import 'package:dartz/dartz.dart';
import 'package:sakinah/core/database/database_helper.dart';
import 'package:sakinah/core/errors/exception.dart';
import 'package:sakinah/core/strings/db_constants.dart';
import 'package:sakinah/features/notes/data/models/list_tasks_model.dart';
import 'package:sakinah/features/notes/data/models/note_model.dart';

abstract class NotesLocalDataSource {
  //notes
  Future<List<NoteModel>> getAllNotes();
  Future<Unit> addNote(NoteModel note);
  Future<Unit> updateNote(NoteModel note);
  Future<Unit> deleteNote(int id);

  //list tasks
  Future<List<ListTasksModel>> getAllListTasks();
  Future<Unit> addListTasks(ListTasksModel listTasks);
  Future<Unit> updateListTasks(ListTasksModel listTasks);
  Future<Unit> deleteListTasks(String id);
}

class NotesLocalDataSourceImpl implements NotesLocalDataSource {
  final DatabaseHelper databaseHelper;
  NotesLocalDataSourceImpl({required this.databaseHelper});

  //notes
  @override
  Future<List<NoteModel>> getAllNotes() async {
    try {
      final db = await databaseHelper.database;
      final result = await db.query(DbConstants.noteTableName);
      final allnotes = result.map((e) => NoteModel.fromJson(e)).toList();
      return await Future.value(allnotes);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<Unit> addNote(NoteModel note) async {
    try {
      final db = await databaseHelper.database;
      await db.insert(DbConstants.noteTableName, {
        DbConstants.noteTitle: note.title,
        DbConstants.noteDescription: note.content,
        DbConstants.noteDate: note.createdAt.toIso8601String(),
      });
      return await Future.value(unit);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<Unit> updateNote(NoteModel note) async {
    try {
      final db = await databaseHelper.database;
      await db.update(
        DbConstants.noteTableName,
        note.toJson(),
        where: '${DbConstants.noteId} = ?',
        whereArgs: [note.id],
      );
      return await Future.value(unit);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<Unit> deleteNote(int id) async {
    try {
      final db = await databaseHelper.database;
      await db.delete(
        DbConstants.noteTableName,
        where: '${DbConstants.noteId} = ?',
        whereArgs: [id],
      );
      return await Future.value(unit);
    } catch (e) {
      throw CacheException();
    }
  }

  //list tasks
  @override
  Future<List<ListTasksModel>> getAllListTasks() async {
    try {
      final db = await databaseHelper.database;
      final result = await db.query(DbConstants.listTasksTableName);
      final listTasks = result.map((e) => ListTasksModel.fromJson(e)).toList();
      return await Future.value(listTasks);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<Unit> addListTasks(ListTasksModel listTasks) async {
    try {
      final db = await databaseHelper.database;
      await db.insert(DbConstants.listTasksTableName, {
        DbConstants.listTasksTitle: listTasks.title,
        DbConstants.listTasksDescription: listTasks.task,
        DbConstants.listTasksIsDone: listTasks.isDone ? 1 : 0,
        DbConstants.listTasksDate: listTasks.date,
        DbConstants.taskOrder: listTasks.order,
      });

      return await Future.value(unit);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<Unit> updateListTasks(ListTasksModel listTasks) async {
    try {
      final db = await databaseHelper.database;
      await db.update(
        DbConstants.listTasksTableName,
        listTasks.toJson(),
        where: '${DbConstants.listTasksId} = ?',
        whereArgs: [listTasks.id],
      );
      return await Future.value(unit);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<Unit> deleteListTasks(String id) async {
    try {
      final db = await databaseHelper.database;
      await db.delete(
        DbConstants.listTasksTableName,
        where: '${DbConstants.listTasksId} = ?',
        whereArgs: [id],
      );
      return await Future.value(unit);
    } catch (e) {
      throw CacheException();
    }
  }
}
