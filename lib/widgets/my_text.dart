import 'package:admin/utils/app_color.dart';
import 'package:admin/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyText extends StatelessWidget {
  final String data;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? height;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;

  const MyText(this.data,
      {Key? key,
      this.fontSize,
      this.color,
      this.fontWeight,
      this.letterSpacing,
      this.overflow,
      this.maxLines,
      this.height,
      this.textAlign,
      this.textDecoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        color: color ?? blueDark,
        fontSize: fontSize ?? 12.sp,
        fontWeight: fontWeight ?? fwRegular,
        letterSpacing: letterSpacing,
        decoration: textDecoration,
        height: height,
      ),
    );
  }
}
