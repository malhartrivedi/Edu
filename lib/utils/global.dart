import 'package:admin/utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Global {
  static void showSnackBar(BuildContext context, String message,
      {Color? backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: EdgeInsets.all(10.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        behavior: SnackBarBehavior.floating,
        shape: StadiumBorder(),
        backgroundColor: backgroundColor ?? red,
        content: Text(
          message,
          style: TextStyle(color: white, fontSize: 14.sp,),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
