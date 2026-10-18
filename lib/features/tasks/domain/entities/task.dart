import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String name;
  final String image;
  final DateTime date;
  const Task({required this.name, required this.date, required this.image});

  @override
  List<Object?> get props => [name, date, image];
}
