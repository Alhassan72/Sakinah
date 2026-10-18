import 'package:equatable/equatable.dart';

class Record extends Equatable {
  final int? id;
  final String title;
  final String path;
  final DateTime date;
  final String duration;
  final bool isPlaying;
  const Record({
    required this.title,
    required this.path,
    required this.date,
    required this.duration,
    required this.isPlaying,
    this.id,
  });
  @override
  List<Object?> get props => [title, path, date, duration, isPlaying];
}
