import 'package:flutter/material.dart';
import 'package:sakinah/core/utils/app_color.dart';
import 'package:sakinah/features/notes/domain/entities/list_tasks.dart';
import 'package:sakinah/features/notes/domain/entities/note.dart';
import 'package:sakinah/features/notes/presentation/widgets/add_note_task_widgets/add_note_task_body.dart';
import 'package:sakinah/features/notes/presentation/widgets/add_note_task_widgets/add_note_task_header.dart';

class AddEditNoteOrTasks extends StatelessWidget {
  final bool isnote;
  final Note? note;
  final String? initialTasksTitle;
  final List<ListTasks>? initialTasks;

  const AddEditNoteOrTasks({
    super.key,
    required this.isnote,
    this.note,
    this.initialTasksTitle,
    this.initialTasks,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final TextEditingController titleController = TextEditingController(
      text: isnote ? (note?.title ?? '') : (initialTasksTitle ?? ''),
    );
    final TextEditingController descriptionController = TextEditingController(
      text: note?.content ?? '',
    );

    return Scaffold(
      backgroundColor: colors.background,
      appBar: addNoteTaskHeader(
        context,
        titleController,
        descriptionController,
        isnote,
        note,
        initialTasks,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: AddNoteTaskBody(
          isnote: isnote,
          titleController: titleController,
          descriptionController: descriptionController,
        ),
      ),
    );
  }
}
