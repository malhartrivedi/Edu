import 'package:admin/utils/app_color.dart';
import 'package:admin/utils/constants.dart';
import 'package:admin/views/home/teacher/teacher_registration_page.dart';
import 'package:admin/widgets/my_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeacherPage extends StatefulWidget {
  const TeacherPage({Key? key}) : super(key: key);

  @override
  _TeacherPageState createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: _getAppBar(),
      body: _getBody(),
    );
  }

  _getAppBar() {
    return AppBar(
      backgroundColor: blueDarkLight2,
      centerTitle: false,
      title: Text(
        Constants.teacher,
        style: ExtraBoldTextStyle,
      ),
      actions: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TeacherRegistrationPage(),
              ),
            );
          },
          borderRadius: BorderRadius.circular(8.w),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: whiteOff),
              borderRadius: BorderRadius.circular(8.w),
            ),
            alignment: Alignment.center,
            margin: EdgeInsets.all(8.w),
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Text(
              Constants.add.toUpperCase(),
              style: h2TextStyle,
            ),
          ),
        ),
      ],
    );
  }

  _getBody() {
    return Center(
      child: Text('No Data Found'),
    );
  }
}
