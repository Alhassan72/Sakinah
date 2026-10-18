import 'package:equatable/equatable.dart';

class Tasbeeh extends Equatable {
  final String name;
  final int count;

  const Tasbeeh({required this.name, required this.count});

  @override
  List<Object?> get props => [name, count];
}
