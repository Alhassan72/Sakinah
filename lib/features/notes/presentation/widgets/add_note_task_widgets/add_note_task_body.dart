import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakinah/core/utils/app_color.dart';
import 'package:sakinah/features/notes/presentation/widgets/add_note_task_widgets/tasks_list_widget.dart';

class AddNoteTaskBody extends StatelessWidget {
  final bool isnote;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  const AddNoteTaskBody({
    super.key,
    required this.isnote,
    required this.titleController,
    required this.descriptionController,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      children: [
        TextField(
          controller: titleController,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: colors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: isnote ? "Title" : "Tasks List Title",
            hintStyle: TextStyle(
              fontSize: 18.sp,
              color: colors.textSecondary.withValues(alpha: 0.4),
            ),
            border: InputBorder.none,
          ),
        ),
        const Divider(),
        Expanded(
          child: isnote
              ? TextField(
                  controller: descriptionController,
                  maxLines: null,
                  expands: true,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: colors.textPrimary,
                    height: 1.5,
                  ),
                  decoration: InputDecoration(
                    hintText: "Write your note here...",
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: colors.textSecondary.withValues(alpha: 0.4),
                    ),
                    border: InputBorder.none,
                  ),
                )
              : const TasksListWidget(),
        ),
      ],
    );
  }
}
