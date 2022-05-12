import 'package:admin/model/child_model.dart';
import 'package:admin/model/class_model.dart';
import 'package:admin/service/firestore_methods.dart';
import 'package:admin/utils/app_color.dart';
import 'package:admin/utils/app_fonts.dart';
import 'package:admin/utils/constants.dart';
import 'package:admin/utils/global.dart';
import 'package:admin/widgets/my_loading.dart';
import 'package:admin/widgets/my_text.dart';
import 'package:admin/widgets/my_textstyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssignChildPage extends StatefulWidget {
  AssignChildPage(this.classModel, this.classRef, {Key? key}) : super(key: key);

  ClassModel classModel;
  DocumentReference classRef;

  @override
  _AssignChildPageState createState() => _AssignChildPageState();
}

class _AssignChildPageState extends State<AssignChildPage> {
  List<String> children = <String>[];

  @override
  void initState() {
    setState(() {
      children.clear();
      children.addAll(widget.classModel.children);
    });
    super.initState();
  }

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
        Constants.assignChild,
        style: ExtraBoldTextStyle,
      ),
      actions: [
        FutureBuilder<QuerySnapshot<ChildModel>>(
          future: FirestoreMethods()
        .getChildInstituteId(widget.classModel.instituteId)
        .get(),
          builder: (context, snapshot) {
            return InkWell(
              onTap: () async {
                await widget.classRef.update(widget.classModel.toJson());
                ClassModel cModel = widget.classModel;
                Global.showSnackBar(context, Constants.childrenUpdatedSuccessfully,backgroundColor: green);
                Navigator.pop(context,cModel);
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
                  Constants.submit.toUpperCase(),
                  style: h2TextStyle,
                ),
              ),
            );
          }
        ),
      ],
    );
  }

  _getBody() {
    return StreamBuilder<QuerySnapshot<ChildModel>>(
        stream: FirestoreMethods()
            .getChildInstituteId(widget.classModel.instituteId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const MyLoading();
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            padding: EdgeInsets.symmetric(
              horizontal: 4.w,
              vertical: 6.h,
            ),
            itemBuilder: (context, index) {
              ChildModel model = snapshot.data!.docs[index].data();
              DocumentReference reference =
                  snapshot.data!.docs[index].reference;
              return InkWell(
                onTap: () {
                  setState(() {
                    if(widget.classModel.children.contains(model.id)){
                      widget.classModel.children.remove(model.id);
                    }else{
                      widget.classModel.children.add(model.id);
                    }
                  });
                },
                child: Container(
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
                              model.name,
                              fontSize: 14.sp,
                              fontWeight: fwSemiBold,
                            ),
                            SizedBox(height: 2.h),
                          ],
                        ),
                      ),
                      if(widget.classModel.children.contains(model.id))
                      Padding(
                        padding: EdgeInsets.all(8.w),
                        child: Icon(
                          Icons.check_circle_outline,
                          color: greenLight,
                          size: 32.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  _nameIcon(ChildModel model) {
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
            '${model.name[0].toUpperCase()}',
            color: whiteOff,
            fontSize: 20.sp,
            fontWeight: fwBold,
          ),
        ),
      ),
    );
  }
}
