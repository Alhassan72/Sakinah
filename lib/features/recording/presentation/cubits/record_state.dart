import 'package:equatable/equatable.dart';

import '../../domain/entities/record.dart';

sealed class RecordState extends Equatable {
  const RecordState();

  @override
  List<Object> get props => [];
}

class RecordInitial extends RecordState {}

class RecordLoading extends RecordState {}

class RecordLoaded extends RecordState {
  final List<Record> records;
  const RecordLoaded({required this.records});

  @override
  List<Object> get props => [records];
}

class RecordEmpty extends RecordState {}

class RecordError extends RecordState {
  final String message;
  const RecordError({required this.message});

  @override
  List<Object> get props => [message];
}

class RecordSuccessAddDelete extends RecordState {
  final String message;
  const RecordSuccessAddDelete({required this.message});

  @override
  List<Object> get props => [message];
}
