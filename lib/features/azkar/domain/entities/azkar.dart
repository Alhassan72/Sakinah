import 'package:equatable/equatable.dart';

class Azkar extends Equatable {
  final String title;
  final String content;
  final int count;

  const Azkar({
    required this.title,
    required this.content,
    required this.count,
  });

  @override
  List<Object?> get props => [title, content, count];
}
