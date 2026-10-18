import 'package:dartz/dartz.dart';
import 'package:sakinah/core/errors/failure.dart';
import 'package:sakinah/features/recording/domain/entities/record.dart';
import 'package:sakinah/features/recording/domain/repository/record_repository.dart';

class AddRecordUceCase {
  final RecordRepository recordRepository;
  AddRecordUceCase(this.recordRepository);
  Future<Either<Failure, Unit>> call(Record record) async {
    return await recordRepository.addRecord(record);
  }
}
