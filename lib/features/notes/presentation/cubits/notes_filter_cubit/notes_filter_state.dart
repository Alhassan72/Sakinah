part of 'notes_filter_cubit.dart';

class NotesFilterState extends Equatable {
  final String query;
  final int filterIndex; // 0: All, 1: Notes, 2: Tasks

  const NotesFilterState({
    this.query = '',
    this.filterIndex = 0,
  });

  NotesFilterState copyWith({
    String? query,
    int? filterIndex,
  }) {
    return NotesFilterState(
      query: query ?? this.query,
      filterIndex: filterIndex ?? this.filterIndex,
    );
  }

  @override
  List<Object?> get props => [query, filterIndex];
}
