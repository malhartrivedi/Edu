import 'package:admin/model/child_model.dart';
import 'package:admin/model/class_model.dart';
import 'package:admin/model/teacher_data_model.dart';
import 'package:admin/service/firestore_methods.dart';
import 'package:admin/utils/app_color.dart';
import 'package:admin/utils/app_fonts.dart';
import 'package:admin/utils/constants.dart';
import 'package:admin/views/home/classes/assign_child_page.dart';
import 'package:admin/views/home/classes/assign_teacher_page.dart';
import 'package:admin/widgets/my_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTabPage extends StatefulWidget {
  HomeTabPage(this.classModel, this.classRef, {Key? key}) : super(key: key);

  ClassModel classModel;
  DocumentReference classRef;

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  late ClassModel classModel;

  @override
  void initState() {
    setState(() {
      classModel = widget.classModel;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8.h),
        _getTeacherBody(),
        SizedBox(height: 8.h),
        _getChildrenBody(),
      ],
    );
  }

  _getTeacherBody() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 6.h,
      ),
      decoration: BoxDecoration(
          color: blueDarkLight30, borderRadius: BorderRadius.circular(12.w)),
      child: Row(
        children: [
          SizedBox(width: 6.w),
          Icon(
            classModel.teacherId!.isEmpty
                ? Icons.error_outline
                : Icons.check_circle_outline,
            color: widget.classModel.teacherId!.isEmpty ? red : green,
            size: 32,
          ),
          SizedBox(width: 6.w),
          classModel.teacherId!.isEmpty
              ? Text(Constants.noTeacherAssigned)
              : FutureBuilder<QuerySnapshot<TeacherDataModel>>(
                  future: FirestoreMethods()
                      .getTeachersByUid(classModel.teacherId)
                      .get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return CircularProgressIndicator(
                        color: blueDark,
                      );
                    TeacherDataModel tModel = snapshot.data!.docs.first.data();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          tModel.name!,
                          fontWeight: fwSemiBold,
                        ),
                        MyText(tModel.email!),
                      ],
                    );
                  }),
          Spacer(),
          ElevatedButton(
            onPressed: () async {
              var result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AssignTeacherPage(classModel, widget.classRef),
                ),
              );
              if (result != null) {
                setState(() {
                  classModel = result;
                });
              }
            },
            style: ElevatedButton.styleFrom(primary: white),
            child: Text(
              classModel.teacherId!.isEmpty ? Constants.addB : Constants.editB,
              style: TextStyle(color: black),
            ),
          ),
          SizedBox(width: 6.w),
        ],
      ),
    );
  }

  _getChildrenBody() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 6.h,
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 6.w),
              classModel.children.isEmpty
                  ? Icon(
                      Icons.error_outline,
                      color: red,
                      size: 32,
                    )
                  : Container(),
              SizedBox(width: 6.w),
              classModel.children.isEmpty
                  ? Text(Constants.noChildrenSelected)
                  : MyText('Children- ${classModel.children.length}',
                      fontSize: 16, fontWeight: FontWeight.bold),
              Spacer(),
              ElevatedButton(
                onPressed: () async {
                  var answer = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AssignChildPage(classModel, widget.classRef)));
                  if (answer != null) {
                    setState(() {
                      classModel = answer;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(primary: blueDarkLight3),
                child: Text(
                    classModel.children.isEmpty
                        ? Constants.addB
                        : Constants.editB,
                    style: TextStyle(color: black)),
              ),
              SizedBox(width: 6.w),
            ],
          ),
          _displayChildren(),
        ],
      ),
    );
  }

  _displayChildren() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        primary: false,
        shrinkWrap: true,
        itemCount: widget.classModel.children.length,
        itemBuilder: (context, index) {
          return Container(
            height: 46.h,
            margin: EdgeInsets.symmetric(
              horizontal: 2.w,
              vertical: 6.h,
            ),
            decoration: BoxDecoration(
                color: blueDarkLight30,
                borderRadius: BorderRadius.circular(12.w),
                border: Border.all(
                    color: widget.classModel.children.isEmpty == true
                        ? white
                        : blueDark)),
            child: FutureBuilder<QuerySnapshot<ChildModel>>(
                future: FirestoreMethods()
                    .getChildrenByUid(classModel.children[index])
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return LinearProgressIndicator();
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              snapshot.data!.docs.first.data().name,
                              fontSize: 18.h,
                              height: 0.7,
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  MyText(
                                    'DOB: ',
                                    color: blueDarkLight3,
                                    fontSize: 14,
                                    height: 1.1,
                                  ),
                                  MyText(snapshot.data!.docs.first.data().dob,
                                      fontSize: 14, height: 1.1),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Expanded(
                                child: MyText(
                                  'Gender:',
                                  color: blueDarkLight3,
                                  fontSize: 14,
                                  height: 1,
                            )),
                            Expanded(
                                child: MyText(
                                  snapshot.data!.docs.first.data().gender,
                                  fontSize: 14,
                                  height: 1,
                            )),
                          ],
                        )
                      ],
                    ),
                  );
                }),
          );
        });
  }
}