import 'package:sakinah/features/notes/domain/entities/list_tasks.dart';
import 'package:sakinah/features/notes/domain/entities/note.dart';

class NotesViewData {
  final List<Note> notes;
  final Map<String, List<ListTasks>> groupedTasks;
  final bool showNotes;
  final bool showTasks;

  const NotesViewData({
    this.notes = const [],
    this.groupedTasks = const {},
    this.showNotes = true,
    this.showTasks = true,
  });

  bool get isEmpty =>
      (!showNotes || notes.isEmpty) && (!showTasks || groupedTasks.isEmpty);
}
