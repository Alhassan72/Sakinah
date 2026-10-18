import 'package:equatable/equatable.dart';

class Surah extends Equatable {
  final int number;
  final String name;
  final int numberOfAyahs;
  final bool love;

  const Surah({
    required this.number,
    required this.name,
    required this.numberOfAyahs,
    required this.love,
  });

  @override
  List<Object?> get props => [number, name, numberOfAyahs, love];
}
