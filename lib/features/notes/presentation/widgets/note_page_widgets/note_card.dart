import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakinah/core/utils/app_color.dart';
import 'package:sakinah/features/notes/domain/entities/note.dart';
import 'package:sakinah/features/notes/presentation/cubits/note_cubit/notes_cubit.dart';
import 'package:sakinah/features/notes/presentation/pages/add_edit_note_or_tasks_.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  const NoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: colors.primaryInverse,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colors.textSecondary.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  note.title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: colors.textPrimary,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Edit Button
                  InkWell(
                    borderRadius: BorderRadius.circular(8.r),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddEditNoteOrTasks(isnote: true, note: note),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(6.w),
                      child: Icon(
                        Icons.edit_outlined,
                        size: 18.sp,
                        color: colors.deep,
                      ),
                    ),
                  ),
                  // Delete Button
                  InkWell(
                    borderRadius: BorderRadius.circular(8.r),
                    onTap: () {
                      if (note.id != null) {
                        context.read<NotesCubit>().deleteNote(note.id!);
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.all(6.w),
                      child: Icon(
                        Icons.delete_outline,
                        size: 18.sp,
                        color: colors.error,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (note.content.isNotEmpty) ...[
            SizedBox(height: 6.h),
            Text(
              note.content,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13.sp,
                color: colors.textSecondary,
                height: 1.4,
              ),
            ),
          ],
          SizedBox(height: 8.h),
          Text(
            "${note.createdAt.year}-${note.createdAt.month.toString().padLeft(2, '0')}-${note.createdAt.day.toString().padLeft(2, '0')}",
            style: TextStyle(
              fontSize: 10.sp,
              color: colors.textSecondary.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}
