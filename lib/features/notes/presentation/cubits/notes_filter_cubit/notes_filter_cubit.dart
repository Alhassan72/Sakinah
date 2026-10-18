import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sakinah/core/utils/search.dart';
import 'package:sakinah/features/notes/domain/entities/list_tasks.dart';
import 'package:sakinah/features/notes/domain/entities/note.dart';
import 'package:sakinah/features/notes/presentation/cubits/list_tasks_cubit/list_tasks_cubit.dart';
import 'package:sakinah/features/notes/presentation/cubits/note_cubit/notes_cubit.dart';
import 'package:sakinah/core/models/notes_view_data.dart';

part 'notes_filter_state.dart';

class NotesFilterCubit extends Cubit<NotesFilterState> {
  NotesFilterCubit() : super(const NotesFilterState());

  void setQuery(String query) {
    emit(state.copyWith(query: query));
  }

  void setFilterIndex(int filterIndex) {
    emit(state.copyWith(filterIndex: filterIndex));
  }

  void reset() {
    emit(const NotesFilterState());
  }

  NotesViewData processData({
    required NotesState notesState,
    required ListTasksState tasksState,
  }) {
    final rawNotes = (notesState is NotesLoaded) ? notesState.notes : <Note>[];
    final filteredNotes = rawNotes.search(
      query: state.query,
      selector: (note) => "${note.title} ${note.content}",
    );

    final rawTasks = (tasksState is ListTasksLoaded)
        ? tasksState.tasks
        : <ListTasks>[];
    final filteredTasks = rawTasks.search(
      query: state.query,
      selector: (task) => "${task.title} ${task.task}",
    );

    final Map<String, List<ListTasks>> groupedTasks = {};
    for (final t in filteredTasks) {
      groupedTasks.putIfAbsent(t.title, () => []).add(t);
    }

    final showNotes = state.filterIndex == 0 || state.filterIndex == 1;
    final showTasks = state.filterIndex == 0 || state.filterIndex == 2;

    return NotesViewData(
      notes: showNotes ? filteredNotes : [],
      groupedTasks: showTasks ? groupedTasks : {},
      showNotes: showNotes,
      showTasks: showTasks,
    );
  }
}
