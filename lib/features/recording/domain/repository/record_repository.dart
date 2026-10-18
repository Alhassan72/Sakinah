import 'package:dartz/dartz.dart';
import 'package:sakinah/core/errors/failure.dart';
import 'package:sakinah/features/recording/domain/entities/record.dart';

abstract class RecordRepository {
  Future<Either<Failure, List<Record>>> allRecords();
  Future<Either<Failure, Unit>> addRecord(Record record);
  Future<Either<Failure, Unit>> deleteRecord(int id);
}
