import 'package:equatable/equatable.dart';

class ListTasks extends Equatable {
  final String? id;
  final String title;
  final String task;
  final bool isDone;
  final int order;
  final String date;

  const ListTasks({
    this.id,
    required this.title,
    required this.date,
    required this.task,
    required this.isDone,
    required this.order,
  });

  @override
  List<Object?> get props => [title, date, task, order, isDone];
}
