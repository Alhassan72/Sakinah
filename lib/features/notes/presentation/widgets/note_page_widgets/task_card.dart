import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakinah/core/utils/app_color.dart';
import 'package:sakinah/features/notes/domain/entities/list_tasks.dart';
import 'package:sakinah/features/notes/presentation/cubits/list_tasks_cubit/list_tasks_cubit.dart';
import 'package:sakinah/features/notes/presentation/pages/add_edit_note_or_tasks_.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final List<ListTasks> tasks;
  const TaskCard({super.key, required this.title, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final cubit = context.read<ListTasksCubit>();
    final completedCount = tasks.where((t) => t.isDone).length;

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
          // Task Group Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: colors.textPrimary,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: colors.gold.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        "$completedCount/${tasks.length}",
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: colors.deep,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Edit Group Button
                  InkWell(
                    borderRadius: BorderRadius.circular(8.r),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddEditNoteOrTasks(
                            isnote: false,
                            initialTasksTitle: title,
                            initialTasks: tasks,
                          ),
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
                  // Delete Group Button
                  InkWell(
                    borderRadius: BorderRadius.circular(8.r),
                    onTap: () {
                      cubit.deleteTasksGroup(title);
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
          const Divider(),
          // Task Items List
          ...tasks.map(
            (item) => Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Row(
                children: [
                  SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: Checkbox(
                      value: item.isDone,
                      activeColor: colors.deep,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      onChanged: (_) {
                        cubit.toggleSavedTask(item);
                      },
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      item.task,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: item.isDone
                            ? colors.textSecondary.withValues(alpha: 0.6)
                            : colors.textPrimary,
                        decoration: item.isDone
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
