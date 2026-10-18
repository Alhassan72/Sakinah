import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakinah/core/utils/app_color.dart';
import 'package:sakinah/features/notes/presentation/cubits/list_tasks_cubit/list_tasks_cubit.dart';
import 'package:sakinah/features/notes/presentation/pages/add_edit_note_or_tasks_.dart';

class NoteFloatButton extends StatelessWidget {
  const NoteFloatButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final ValueNotifier<bool> isOpenNotifier = ValueNotifier<bool>(false);

    return ValueListenableBuilder<bool>(
      valueListenable: isOpenNotifier,
      builder: (context, isOpen, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (isOpen) ...[
              // New Note Option
              _buildOption(
                context: context,
                icon: Icons.note_add_outlined,
                label: 'ملاحظة جديدة',
                onTap: () {
                  isOpenNotifier.value = false;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddEditNoteOrTasks(isnote: true),
                    ),
                  );
                },
              ),
              SizedBox(height: 12.h),

              // New Task Option
              _buildOption(
                context: context,
                icon: Icons.task_alt_outlined,
                label: 'قائمة مهام جديدة',
                onTap: () {
                  isOpenNotifier.value = false;
                  context.read<ListTasksCubit>().initTaskList();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddEditNoteOrTasks(isnote: false),
                    ),
                  );
                },
              ),
              SizedBox(height: 12.h),
            ],

            // Main FAB Button
            FloatingActionButton(
              heroTag: 'notes_main_fab',
              backgroundColor: colors.gold,
              foregroundColor: colors.deep,
              elevation: 4,
              shape: const CircleBorder(),
              onPressed: () {
                isOpenNotifier.value = !isOpenNotifier.value;
              },
              child: AnimatedRotation(
                turns: isOpen ? 0.125 : 0.0, // Rotate + to x
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  isOpen ? Icons.close : Icons.add,
                  size: 28.sp,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildOption({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final colors = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Label Card
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: colors.primaryInverse,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                fontFamily: "Amiri",
                color: colors.textPrimary,
              ),
            ),
          ),
          SizedBox(width: 8.w),

          // Small Action Circle Button
          Container(
            width: 42.w,
            height: 42.h,
            decoration: BoxDecoration(
              color: colors.deep,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: colors.deep.withValues(alpha: 0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(icon, color: colors.gold, size: 20.sp),
          ),
        ],
      ),
    );
  }
}
