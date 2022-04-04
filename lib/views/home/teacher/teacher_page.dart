import 'package:admin/utils/app_color.dart';
import 'package:admin/utils/constants.dart';
import 'package:admin/views/home/teacher/teacher_registration_page.dart';
import 'package:admin/widgets/my_textstyle.dart';
import 'package:flutter/cupertino.dart';
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
    return ListView.builder(
        itemCount: 3,
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
        itemBuilder: (context, index){
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
                border: Border.all(color: blueDarkLight3),
                borderRadius: BorderRadius.circular(14.w)),
            child: Row(
              children: [
                _nameIcon(),
                SizedBox(width: 6.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                     'Raju',
                      style: NameBoldTextStyle,
                    ),
                    Text(
                      'Raju@gmail.com',
                      style: emailBoldTextStyle,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
    );
  }

  _nameIcon() {
    var Firstname = Constants.teacherInitial;
    return SizedBox(
      height: 56.w,
      width: 56.w,
      child: Card(
        color: blueDarkLight2,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.w),
        ),
        child: Center(
          child: Text(
            '${Firstname[0].toUpperCase()}',
            style: iconClassTextStyle,
          ),
        ),
      ),
    );
  }
}
