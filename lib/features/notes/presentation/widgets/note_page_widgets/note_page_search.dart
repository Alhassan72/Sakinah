import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakinah/core/utils/app_color.dart';
import 'package:sakinah/features/notes/presentation/cubits/notes_filter_cubit/notes_filter_cubit.dart';

class NotePageSearch extends StatelessWidget {
  const NotePageSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      height: 46.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: colors.primaryInverse,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: colors.textPrimary.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: colors.textSecondary.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: colors.gold, size: 20.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              onChanged: (val) {
                context.read<NotesFilterCubit>().setQuery(val);
              },
              style: TextStyle(fontSize: 14.sp, color: colors.textPrimary),
              decoration: InputDecoration(
                hintText: "Search your notes or tasks",
                hintStyle: TextStyle(
                  fontSize: 13.sp,
                  color: colors.textSecondary.withValues(alpha: 0.6),
                ),
                border: InputBorder.none,
                isCollapsed: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
