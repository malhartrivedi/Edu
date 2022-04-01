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
  const HomePage({Key? key,required String uid}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formKey = GlobalKey<FormState>();
  final classController = TextEditingController();

  String get classes => classController.value.text;
  bool ClassFocus = false;
  bool _isClassValid = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: whiteOff,
        body: _getHomeBody(),
      ),
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
              context, MaterialPageRoute(builder: (context) => TeacherPage())),
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
              context, MaterialPageRoute(builder: (context) => ParentPage())),
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
                InkWell(
                  onTap: () => _getBottomSheet(),
                  child: Icon(
                    icAdd,
                    color: blueDarkLight2,
                  ),
                ),
              ],
            ),
          ),
          _getClassesListView(),
        ],
      ),
    );
  }

  _getBottomSheet() {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: whiteOff,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
    ),
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: SizedBox(
              height: 242.h,
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 24.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Constants.createClass,
                          style: classTextStyle,
                        ),
                        InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Icon(Icons.close)),
                      ],
                    ),
                  ),
                  Divider(color: blueDarkLight2, height: 1),
                  SizedBox(height: 8.h),
                  _createClassesTextField(),
                  SizedBox(height: 8.h),
                  _submitButton(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _createClassesTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: _getContainerOutLine(
        hasFocus: ClassFocus == true,
        child: Focus(
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: classController,
            keyboardType: TextInputType.text,
            style: h2TextStyle,
            decoration: InputDecoration(
              suffixIcon: Icon(
                Icons.check,
                color: _isClassValid == true ? blueDark : grey,
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              labelText: Constants.classes,
              labelStyle: TextStyle(
                color: greyDark,
              ),
            ),
            validator: (name) {
              if (name!.isEmpty) {
                _isClassValid = false;
                return Constants.enterName;
              } else if (name.trim().length < 6) {
                _isClassValid = true;
                return Constants.validName;
              }
              return null;
            },
          ),
          onFocusChange: (name) {
            setState(() {
              ClassFocus = name;
            });
          },
        ),
      ),
    );
  }

  _submitButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      child: ElevatedButton(
        onPressed: () {
          if (!formKey.currentState!.validate()) {
            return;
          } else if (classController.text.isNotEmpty) {
            return Navigator.pop(context);
          }
        },
        style: ElevatedButton.styleFrom(
          primary: greyGreenDarkLight,
          minimumSize: Size.fromHeight(50.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(Constants.submit),
      ),
    );
  }

  _getContainerOutLine({required Widget child, required bool hasFocus}) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: greyLight30,
        borderRadius: BorderRadius.all(Radius.circular(14.w)),
        border: Border.all(color: hasFocus ? blueDark : white),
      ),
      child: child,
    );
  }

  _getClassesListView() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                  child: _classesName(),
                ),
                Text(
                  Constants.classList,
                  style: ThemeEmailBoldTextStyle,
                ),
              ],
            ),
            Divider(color: blueDarkLight2, height: 1),
          ],
        );
      },
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
