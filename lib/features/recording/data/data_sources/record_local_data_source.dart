import 'package:dartz/dartz.dart';
import 'package:sakinah/core/database/database_helper.dart';
import 'package:sakinah/core/errors/exception.dart';
import 'package:sakinah/core/strings/db_constants.dart';
import 'package:sakinah/features/recording/data/models/record_model.dart';

abstract class RecordLocalDataSource {
  Future<List<RecordModel>> allRecords();
  Future<Unit> addRecord(RecordModel record);
  Future<Unit> deleteRecord(int id);
}

class RecordLocalDataSourceImpl implements RecordLocalDataSource {
  final DatabaseHelper databaseHelper;

  RecordLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<List<RecordModel>> allRecords() async {
    try {
      final db = await databaseHelper.database;
      final result = await db.query(DbConstants.recordingsTableName);
      final allrecords = result.map((e) => RecordModel.fromJson(e)).toList();
      return await Future.value(allrecords);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<Unit> addRecord(RecordModel record) async {
    try {
      final db = await databaseHelper.database;
      await db.insert(DbConstants.recordingsTableName, {
        DbConstants.recordingName: record.title,
        DbConstants.recordingPath: record.path,
        DbConstants.recordingDuration: record.duration,
        DbConstants.recordingDate: record.date.toIso8601String(),
        DbConstants.recordingPlay: record.isPlaying,
      });
      return await Future.value(unit);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<Unit> deleteRecord(int id) async {
    try {
      final db = await databaseHelper.database;
      await db.delete(
        DbConstants.recordingsTableName,
        where: '${DbConstants.recordingId} = ?',
        whereArgs: [id],
      );
      return await Future.value(unit);
    } catch (e) {
      throw CacheException();
    }
  }
}
