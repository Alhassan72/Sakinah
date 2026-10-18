import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakinah/core/utils/app_color.dart';

class ErrorMessage extends StatelessWidget {
  final String message;
  const ErrorMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, size: 56.sp, color: colors.error),
          SizedBox(height: 12.h),
          Text(
            message,
            style: TextStyle(color: colors.error, fontSize: 13.sp),
          ),
        ],
      ),
    );
  }
}
