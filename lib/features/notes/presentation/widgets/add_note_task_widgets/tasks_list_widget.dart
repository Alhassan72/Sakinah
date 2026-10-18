// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakinah/core/utils/app_color.dart';
import 'package:sakinah/features/notes/presentation/cubits/list_tasks_cubit/list_tasks_cubit.dart';

class TasksListWidget extends StatelessWidget {
  const TasksListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return BlocBuilder<ListTasksCubit, ListTasksState>(
      builder: (context, state) {
        final cubit = context.read<ListTasksCubit>();
        final tasks = (state is ListTasksLoaded) ? state.tasks : [];

        return Column(
          children: [
            Expanded(
              child: tasks.isEmpty
                  ? Center(
                      child: Text(
                        "لا توجد مهام بعد، اضغط على إضافة مهمة بالأسفل",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: colors.textSecondary.withValues(alpha: 0.5),
                        ),
                      ),
                    )
                  : ReorderableListView.builder(
                      buildDefaultDragHandles: false,
                      itemCount: tasks.length,
                      onReorder: (oldIndex, newIndex) {
                        cubit.reorderTasksLocally(oldIndex, newIndex);
                      },
                      itemBuilder: (context, index) {
                        final item = tasks[index];

                        return Padding(
                          key: ValueKey(item.id ?? 'task_item_$index'),
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          child: Row(
                            children: [
                              ReorderableDragStartListener(
                                index: index,
                                child: Icon(
                                  Icons.drag_indicator,
                                  color: colors.textSecondary.withValues(
                                    alpha: 0.5,
                                  ),
                                  size: 20.sp,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Checkbox(
                                value: item.isDone,
                                activeColor: colors.deep,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                onChanged: (value) {
                                  cubit.toggleTaskDone(index, value ?? false);
                                },
                              ),
                              Expanded(
                                child: TextFormField(
                                  initialValue: item.task,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: colors.textPrimary,
                                    decoration: item.isDone
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "اكتب المهمة هنا...",
                                    hintStyle: TextStyle(
                                      fontSize: 14.sp,
                                      color: colors.textSecondary.withValues(
                                        alpha: 0.4,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                  onChanged: (text) {
                                    cubit.updateTaskItemText(index, text);
                                  },
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.redAccent.withValues(
                                    alpha: 0.7,
                                  ),
                                  size: 18.sp,
                                ),
                                onPressed: () {
                                  cubit.removeTaskItem(index);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () {
                    cubit.addNewTaskItem();
                  },
                  icon: Icon(Icons.add, color: colors.deep, size: 20.sp),
                  label: Text(
                    "إضافة عنصر جديد",
                    style: TextStyle(
                      color: colors.deep,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
