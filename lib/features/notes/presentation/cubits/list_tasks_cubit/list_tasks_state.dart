part of 'list_tasks_cubit.dart';

sealed class ListTasksState extends Equatable {
  const ListTasksState();

  @override
  List<Object> get props => [];
}

final class ListTasksInitial extends ListTasksState {}

final class ListTasksLoading extends ListTasksState {}

// Get All List Tasks
final class ListTasksLoaded extends ListTasksState {
  final List<ListTasks> tasks;
  const ListTasksLoaded({required this.tasks});

  @override
  List<Object> get props => [tasks];
}

// Error
final class ListTasksError extends ListTasksState {
  final String message;
  const ListTasksError({required this.message});

  @override
  List<Object> get props => [message];
}

// Success
final class SuccessMessage extends ListTasksState {
  final String message;
  const SuccessMessage({required this.message});

  @override
  List<Object> get props => [message];
}

final class ListTasksEmpty extends ListTasksState {}
