import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakinah/core/utils/app_color.dart';
import 'package:sakinah/features/notes/presentation/cubits/notes_filter_cubit/notes_filter_cubit.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesFilterCubit, NotesFilterState>(
      buildWhen: (previous, current) => previous.filterIndex != current.filterIndex,
      builder: (context, filterState) {
        final filterIndex = filterState.filterIndex;
        final cubit = context.read<NotesFilterCubit>();

        return Row(
          children: [
            _buildFilterChip(
              context: context,
              label: "All",
              isSelected: filterIndex == 0,
              onTap: () => cubit.setFilterIndex(0),
            ),
            SizedBox(width: 8.w),
            _buildFilterChip(
              context: context,
              label: "Notes",
              isSelected: filterIndex == 1,
              onTap: () => cubit.setFilterIndex(1),
            ),
            SizedBox(width: 8.w),
            _buildFilterChip(
              context: context,
              label: "Tasks",
              isSelected: filterIndex == 2,
              onTap: () => cubit.setFilterIndex(2),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFilterChip({
    required BuildContext context,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final colors = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? colors.deep : colors.primaryInverse,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected
                ? colors.deep
                : colors.textSecondary.withValues(alpha: 0.2),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: colors.deep.withValues(alpha: 0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? colors.white : colors.textPrimary,
          ),
        ),
      ),
    );
  }
}
