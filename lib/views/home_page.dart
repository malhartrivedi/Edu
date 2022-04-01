import 'package:admin/utils/app_asset_path.dart';
import 'package:admin/utils/app_color.dart';
import 'package:admin/utils/app_icon.dart';
import 'package:admin/utils/constants.dart';
import 'package:admin/views/parent_page.dart';
import 'package:admin/views/teacher_page.dart';
import 'package:admin/widgets/my_textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteOff,
      body: _getHomeBody(),
    );
  }

  _getHomeBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _getSchool(),
            Divider(color: blueDarkLight2, height: 1),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      _getTeacher(),
                      SizedBox(width: 10),
                      _getParent(),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  _getClasses(),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getSchool() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            height: 50.w,
            width: 50.w,
            child: Card(
              color: greyWhite,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(AssetPath.iconSchool),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.w),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Text(Constants.cnHighSchool, style: schoolTextStyle),
        ],
      ),
    );
  }

  _getTeacher() {
    return Expanded(
      child: SizedBox(
        height: 160.h,
        width: 180.h,
        child: InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TeacherPage())),
          child: Card(
            elevation: 6,
            color: greyWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.w),
            ),
            child: Column(
              children: [
                Image.asset(
                  AssetPath.iconTeacher,
                  height: 112,
                  width: 120,
                ),
                Text(
                  Constants.teacher,
                  style: teacherTextStyle,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getParent() {
    return Expanded(
      child: SizedBox(
        height: 160.h,
        width: 180.h,
        child: InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ParentPage())),
          child: Card(
            elevation: 6,
            color: greyWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.w),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 16.h,
                ),
                Image.asset(
                  AssetPath.iconFamily,
                  height: 86.h,
                  width: 120.h,
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  Constants.parent,
                  style: parentTextStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getClasses() {
    return Card(
      elevation: 6,
      color: whiteOff,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.all(0),
            color: greyWhite,
            child: Row(
              children: [
                SizedBox(
                  height: 46.w,
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Card(
                      color: greyGr,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Image.asset(AssetPath.iconBlackBoard),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.w),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
                Text(Constants.classes, style: classesTextStyle),
                SizedBox(width: 170),
                Icon(
                  icAdd,
                  color: blueDarkLight2,
                ),
              ],
            ),
          ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8,horizontal: 14),
                        child: _classesName(),
                      ),
                      Text('Class 1',style: ThemeEmailBoldTextStyle,),
                    ],
                  ),
                  Divider(color: blueDarkLight2, height: 1),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  _classesName() {
    var Firstname = Constants.classList;
    return SizedBox(
      height: 36.w,
      width: 36.w,
      child: Card(
        color: blueDarkLight2,
        child: Center(
          child: Text(
            '${Firstname[0].toUpperCase()}',
              style: iconClassTextStyle,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.w),
        ),
        elevation: 6,
      ),
    );
  }

}
