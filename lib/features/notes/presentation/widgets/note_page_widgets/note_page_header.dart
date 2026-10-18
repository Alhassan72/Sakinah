import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakinah/core/utils/app_color.dart';
import 'package:sakinah/core/widgets/square_button.dart';

class NotePageHeader extends StatelessWidget {
  const NotePageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomIconButton(
          backgroundcolor: colors.gold.withValues(alpha: 0.15),
          iconcolor: colors.textPrimary,
          radius: 12,
          onTap: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          padding: 7,
          icon: Icons.arrow_back,
        ),
        Text(
          "Notes & Tasks",
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            fontFamily: "Amiri",
            color: colors.textPrimary,
          ),
        ),
        SizedBox(width: 40.w),
      ],
    );
  }
}
