part of 'notes_cubit.dart';

sealed class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

final class NotesInitial extends NotesState {}

final class NotesLoading extends NotesState {}

// Get All Notes
final class NotesLoaded extends NotesState {
  final List<Note> notes;
  const NotesLoaded({required this.notes});
  @override
  List<Object> get props => [notes];
}

// Empty Notes
final class NotesEmpty extends NotesState {}

// Error
final class NotesError extends NotesState {
  final String message;
  const NotesError({required this.message});
  @override
  List<Object> get props => [message];
}

// Success
final class SuccessMessage extends NotesState {
  final String message;
  const SuccessMessage({required this.message});
  @override
  List<Object> get props => [message];
}
