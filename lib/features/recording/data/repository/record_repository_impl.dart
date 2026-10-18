import 'package:dartz/dartz.dart';
import 'package:sakinah/core/errors/exception.dart';
import 'package:sakinah/core/errors/failure.dart';
import 'package:sakinah/features/recording/data/data_sources/record_local_data_source.dart';
import 'package:sakinah/features/recording/data/models/record_model.dart';
import 'package:sakinah/features/recording/domain/repository/record_repository.dart';
import 'package:sakinah/features/recording/domain/entities/record.dart';

class RecordRepositoryImpl implements RecordRepository {
  final RecordLocalDataSource recordLocalDataSource;

  RecordRepositoryImpl({required this.recordLocalDataSource});

  @override
  Future<Either<Failure, List<Record>>> allRecords() async {
    try {
      final records = await recordLocalDataSource.allRecords();
      return Right(records);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addRecord(Record record) async {
    try {
      final recordModel = RecordModel(
        id: record.id,
        title: record.title,
        path: record.path,
        duration: record.duration,
        date: record.date,
        isPlaying: record.isPlaying,
      );
      await recordLocalDataSource.addRecord(recordModel);
      return Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteRecord(int id) async {
    try {
      await recordLocalDataSource.deleteRecord(id);
      return Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
