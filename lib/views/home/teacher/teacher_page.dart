import 'package:admin/model/teacher_data_model.dart';
import 'package:admin/model/user_data_model.dart';
import 'package:admin/service/firestore_methods.dart';
import 'package:admin/utils/app_color.dart';
import 'package:admin/utils/app_fonts.dart';
import 'package:admin/utils/constants.dart';
import 'package:admin/views/home/teacher/teacher_registration_page.dart';
import 'package:admin/widgets/my_loading.dart';
import 'package:admin/widgets/my_text.dart';
import 'package:admin/widgets/my_textstyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeacherPage extends StatefulWidget {
  const TeacherPage({Key? key, required this.adminData}) : super(key: key);

  final UserDataModel adminData;

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
                builder: (context) => TeacherRegistrationPage(
                  adminData: widget.adminData,
                ),
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
    return StreamBuilder<QuerySnapshot<TeacherDataModel>>(
      stream: FirestoreMethods().getTeachers().snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const MyLoading();
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          padding: EdgeInsets.symmetric(
            horizontal: 4.w,
            vertical: 6.h,
          ),
          itemBuilder: (context, index) {
            TeacherDataModel model = snapshot.data!.docs[index].data();
            snapshot.data!.docs[index].reference;
            return Container(
              margin: EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 6.h,
              ),
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                  border: Border.all(color: blueDarkLight3),
                  borderRadius: BorderRadius.circular(14.w)),
              child: Row(
                children: [
                  _nameIcon(model),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          model.name!,
                          fontSize: 14.sp,
                          fontWeight: fwSemiBold,
                        ),
                        SizedBox(height: 2.h),
                        MyText(
                          model.email!,
                          color: greyGreenDark,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Icon(
                      model.uid!.isEmpty
                          ? Icons.error_outline
                          : Icons.check_circle_outline,
                      color: model.uid!.isEmpty ? red90 : greenLight,
                      size: 32.sp,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  _nameIcon(TeacherDataModel model) {
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
          child: MyText(
            '${model.name![0].toUpperCase()}',
            color: whiteOff,
            fontSize: 20.sp,
            fontWeight: fwBold,
          ),
        ),
      ),
    );
  }
}
