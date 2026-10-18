import 'package:equatable/equatable.dart';

class Reader extends Equatable {
  final String name;
  final String url;

  const Reader({required this.name, required this.url});

  @override
  List<Object?> get props => [name, url];
}
