import 'package:dartz/dartz.dart';
import 'package:sakinah/core/errors/failure.dart';
import 'package:sakinah/features/recording/domain/repository/record_repository.dart';

class DeleteRecordUceCase {
  final RecordRepository recordRepository;
  DeleteRecordUceCase(this.recordRepository);
  Future<Either<Failure, Unit>> call(int id) async {
    return await recordRepository.deleteRecord(id);
  }
}
