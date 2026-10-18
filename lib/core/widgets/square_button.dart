import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakinah/core/utils/app_color.dart';

class CustomIconButton extends StatelessWidget {
  final Color backgroundcolor;
  final Color iconcolor;
  final int radius;
  final void Function() onTap;
  final int padding;
  final IconData icon;
  final int iconsize;
  final double opacity;
  const CustomIconButton({
    super.key,
    required this.backgroundcolor,
    required this.iconcolor,
    required this.radius,
    required this.onTap,
    required this.padding,
    required this.icon,
    this.iconsize = 20,
    this.opacity = 0.4,
  });

  @override
  Widget build(BuildContext context) {
    Theme.of(context).extension<AppColors>()!;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(padding.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius.r),
          color: backgroundcolor.withValues(alpha: opacity),
          border: Border.all(color: backgroundcolor),
        ),
        child: Icon(icon, color: iconcolor, size: iconsize.sp),
      ),
    );
  }
}
