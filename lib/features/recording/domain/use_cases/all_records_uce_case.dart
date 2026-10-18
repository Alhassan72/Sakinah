import 'package:dartz/dartz.dart';
import 'package:sakinah/core/errors/failure.dart';
import 'package:sakinah/features/recording/domain/entities/record.dart';
import 'package:sakinah/features/recording/domain/repository/record_repository.dart';

class AllRecordsUceCase {
  final RecordRepository recordRepository;
  AllRecordsUceCase({required this.recordRepository});

  Future<Either<Failure, List<Record>>> call() async {
    return await recordRepository.allRecords();
  }
}
