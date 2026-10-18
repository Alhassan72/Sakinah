import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakinah/core/errors/failure.dart';
import 'package:sakinah/core/strings/succes_message.dart';
import 'package:sakinah/core/utils/map_failure_to_message.dart';
import 'package:sakinah/features/recording/domain/use_cases/add_record_uce_case.dart';
import 'package:sakinah/features/recording/domain/use_cases/all_records_uce_case.dart';
import 'package:sakinah/features/recording/domain/use_cases/delete_record_uce_case.dart';
import 'package:sakinah/features/recording/presentation/cubits/record_state.dart';

import '../../domain/entities/record.dart';

class RecordCubit extends Cubit<RecordState> {
  final AllRecordsUceCase allRecordsUceCase;
  final AddRecordUceCase addRecordUceCase;
  final DeleteRecordUceCase deleteRecordUceCase;
  RecordCubit(
    super.initialState, {
    required this.allRecordsUceCase,
    required this.addRecordUceCase,
    required this.deleteRecordUceCase,
  });

  Future<void> getAllRecords() async {
    emit(RecordLoading());
    final result = await allRecordsUceCase.call();
    result.fold(
      (failure) => emit(RecordError(message: mapFailureToMessage(failure))),
      (records) {
        if (records.isEmpty) {
          emit(RecordEmpty());
        } else {
          emit(RecordLoaded(records: records));
        }
      },
    );
  }

  Future<void> addRecord(Record record) async {
    emit(RecordLoading());
    final result = await addRecordUceCase.call(record);
    _handleEither(result, recordingAddedSuccessfully);
  }

  Future<void> deleteRecord(int id) async {
    emit(RecordLoading());
    final result = await deleteRecordUceCase.call(id);
    _handleEither(result, recordingDeletedSuccessfully);
  }

  Future<void> _handleEither(
    Either<Failure, Unit> result,
    String message,
  ) async {
    result.fold(
      (failure) => emit(RecordError(message: mapFailureToMessage(failure))),
      (_) async {
        emit(RecordSuccessAddDelete(message: message));
        await getAllRecords();
      },
    );
  }
}
