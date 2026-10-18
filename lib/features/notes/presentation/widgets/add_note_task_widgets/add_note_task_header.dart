import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakinah/core/utils/app_color.dart';
import 'package:sakinah/features/notes/domain/entities/list_tasks.dart';
import 'package:sakinah/features/notes/domain/entities/note.dart';
import 'package:sakinah/features/notes/presentation/cubits/list_tasks_cubit/list_tasks_cubit.dart';
import 'package:sakinah/features/notes/presentation/cubits/note_cubit/notes_cubit.dart';

AppBar addNoteTaskHeader(
  BuildContext context,
  TextEditingController titleController,
  TextEditingController descriptionController,
  bool isnote,
  Note? note,
  List<ListTasks>? initialTasks,
) {
  final colors = context.colors;
  return AppBar(
    title: Text(
      isnote
          ? (note == null ? "Add Note" : "Edit Note")
          : (initialTasks == null ? "Add Tasks" : "Edit Tasks"),
      style: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        fontFamily: "Amiri",
      ),
    ),
    leading: IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(Icons.cancel_outlined),
    ),
    actions: [
      TextButton(
        onPressed: () => _save(
          context,
          titleController.text.trim(),
          descriptionController.text.trim(),
          isnote,
          note,
        ),
        child: Text(
          "Save",
          style: TextStyle(
            fontSize: 20.sp,
            color: colors.deep,
            fontWeight: FontWeight.bold,
            fontFamily: "Amiri",
          ),
        ),
      ),
    ],
  );
}

void _save(
  BuildContext context,
  String title,
  String description,
  bool isnote,
  Note? note,
) {
  if (isnote) {
    if (title.isEmpty && description.isEmpty) {
      Navigator.pop(context);
      return;
    }

    context.read<NotesCubit>().saveNote(
      id: note?.id,
      title: title,
      content: description,
      createdAt: note?.createdAt,
    );
  } else {
    final taskTitle = title.isEmpty ? "Untitled" : title;
    context.read<ListTasksCubit>().saveTasksGroup(taskTitle);
  }

  Navigator.pop(context);
}
