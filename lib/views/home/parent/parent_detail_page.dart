import 'package:admin/model/child_model.dart';
import 'package:admin/model/parent_data_model.dart';
import 'package:admin/model/user_data_model.dart';
import 'package:admin/service/firestore_methods.dart';
import 'package:admin/utils/app_color.dart';
import 'package:admin/utils/app_icon.dart';
import 'package:admin/utils/constants.dart';
import 'package:admin/views/home/parent/new_child_page.dart';
import 'package:admin/views/home/parent/parent_edit_page.dart';
import 'package:admin/widgets/my_textstyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ParentDetailPage extends StatefulWidget {
  ParentDetailPage(
      {Key? key,
      required this.parentDataModel,
      required this.parentRef,
      required this.userDataModel,
      required this.userModelReference})
      : super(key: key);
  ParentDataModel parentDataModel;
  DocumentReference parentRef;
  UserDataModel userDataModel;
  final DocumentReference userModelReference;

  @override
  _ParentDetailPageState createState() => _ParentDetailPageState();
}

class _ParentDetailPageState extends State<ParentDetailPage> {

  @override
  void initState() {
    parentDataModel = widget.parentDataModel;
  }
  ChildModel childModelObject = ChildModel(
      id: "",
      name: "",
      dob: "",
      gender: "",
      instituteId: "",
      parentId: "",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now());

  late ParentDataModel parentDataModel;
  bool _isEditEnabled = false;
  bool _isEditCheck = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: _getBody(),
      ),
    );
  }

  _getBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back))),
          ),
          SizedBox(height: 50.h),
          SizedBox(
            height: 120.w,
            width: 120.w,
            child: Card(
              color: greyWhite,
              child: Center(
                child: Text(
                  '${parentDataModel.name[0].toUpperCase()}',
                  style: ThemeBoldTextStyle,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(70.w),
              ),
              elevation: 6,
            ),
          ),
          SizedBox(height: 20.h),
          Text('${parentDataModel.name}', style: ThemeNameBoldTextStyle),
          Text('${parentDataModel.email}', style: ThemeEmailBoldTextStyle),
          SizedBox(height: 32.h),
          _getDivider(),
          _getDetailItem(Constants.phoneB, '+91-${parentDataModel.phone}'),
          _getDivider(),
          _getDetailItem(Constants.schoolB, '${parentDataModel.instituteName}'),
          _getDivider(),
          _getDetailItem(Constants.addressB, '${parentDataModel.address}'),
          _getDivider(),
          _getDetailItem(Constants.cityB, '${parentDataModel.city}'),
          _getDivider(),
          _getDetailItem(Constants.stateB, '${parentDataModel.state}'),
          _getDivider(),
          _getDetailItem(Constants.postB, '${parentDataModel.postcode}'),
          _getDivider(),
          SizedBox(height: 20.h),
          _addNewChild(),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () async {
                      final value = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ParentEditPage(
                              model: parentDataModel,
                              reference: widget.parentRef),
                        ),
                      );
                      if (value != null) {
                        setState(() {
                          parentDataModel = value;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 6.0,
                      primary: greyGreenDarkLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      Constants.editProfileB,
                      textAlign: TextAlign.center,
                      style: sizeWhiteTextStyle,
                    ),
                  ),
                ),
                SizedBox(width: 14.h),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    child: ElevatedButton(
                      onPressed: () => _showDialog(),
                      style: ElevatedButton.styleFrom(
                        elevation: 6.0,
                        primary: greyGreenDarkLight,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        Constants.delete,
                        style: logTextStyle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  _getDivider() {
    return Divider(color: blueDarkLight2, height: 1);
  }

  _getDetailItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: labelTextStyle),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(value,
                textAlign: TextAlign.end, style: ThemeEmailBoldTextStyle),
          ),
        ],
      ),
    );
  }

  _showDialog() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.w)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(Constants.delete, style: logoutTextStyle),
            Icon(Icons.clear, color: red, size: 22.sp),
          ],
        ),
        content: Text(Constants.deleteSure, style: sizeTextStyle),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Padding(
              padding: EdgeInsets.only(left: 50.w),
              child: Text(Constants.no, style: NoTextStyle),
            ),
          ),
          TextButton(
            onPressed: () {
              widget.parentRef.delete();
              Navigator.pop(context);
            },
            child: Text(Constants.yes, style: YesTextStyle),
          )
        ],
      ),
    );
  }

  _addNewChild() {
    return StreamBuilder<QuerySnapshot<ChildModel>>(
        stream:
            FirestoreMethods().getChild(widget.parentDataModel.uid).snapshots(),
        builder: (context, snapshot) {
          var snapShotObj = snapshot.data;
          if (snapShotObj != null) {
            var childModelObj = snapShotObj.size > 0 ? snapShotObj.docs.first.data() : childModelObject;
            var childRefObj = snapShotObj.size > 0 ? snapShotObj.docs.first.reference : null;
            if (snapShotObj.size == 0) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _isEditCheck = false;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewChildPage(
                                    parentDataModel: widget.parentDataModel,
                                    parentRef: widget.parentRef,
                                    userDataModel: widget.userDataModel,
                                    userModelReference: widget.userModelReference,
                                    childModel:  childModelObj,
                                    childRef:  childRefObj,
                                    isEditCheck: _isEditCheck,
                                  )));
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 6.0,
                      primary: greyGreenDarkLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      Constants.addNewB,
                      style: sizeWhiteTextStyle,
                    ),
                  ),
                ),
              );
            } else {
              childModelObj = snapShotObj.docs.first.data();
            }
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Card(
              elevation: 6,
              color: whiteOff,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.w),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: greyWhite,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(12.w)),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 12.w),
                        Text(Constants.children, style: blueDark20BoldTS),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            _isEditCheck = false;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewChildPage(
                                      parentDataModel: widget.parentDataModel,
                                      parentRef: widget.parentRef,
                                      userDataModel: widget.userDataModel,
                                      userModelReference:
                                      widget.userModelReference,
                                      childRef: snapShotObj!.docs.first.reference,
                                      childModel: snapShotObj.docs.first.data(),
                                      isEditCheck: _isEditCheck,
                                    )));

                          },
                          borderRadius: BorderRadius.circular(50),
                          child: Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Icon(
                              icAdd,
                              size: 24.sp,
                              color: blueDarkLight2,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() => _isEditEnabled = !_isEditEnabled);
                          },
                          borderRadius: BorderRadius.circular(50),
                          child: Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Icon(
                              _isEditEnabled
                                  ? Icons.clear
                                  : Icons.edit_outlined,
                              size: 24.sp,
                              color: blueDarkLight2,
                            ),
                          ),
                        ),
                        SizedBox(width: 4.w),
                      ],
                    ),
                  ),
                  _getClassesListView(),
                ],
              ),
            ),
          );
        });
  }

  _getClassesListView() {
    return StreamBuilder<QuerySnapshot<ChildModel>>(
        stream:
            FirestoreMethods().getChild(widget.parentDataModel.uid).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          }
          int itemCount = snapshot.data!.docs.length;
          return ListView.builder(
            scrollDirection: Axis.vertical,
            primary: false,
            shrinkWrap: true,
            itemCount: itemCount,
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
            itemBuilder: (context, index) {
              DocumentReference childRef = snapshot.data!.docs[index].reference;
              ChildModel childModel = snapshot.data!.docs[index].data();
              return IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 4.h),
                        padding: EdgeInsets.all(6.w),
                        decoration: BoxDecoration(
                            border: Border.all(color: blueDarkLight3),
                            borderRadius: BorderRadius.circular(14.w)),
                        child: Row(
                          children: [
                            _classesNameIcon(childModel.name),
                            SizedBox(width: 6.w),
                            Text(
                              childModel.name,
                              style: ThemeEmailBoldTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_isEditEnabled)
                      _getActionIcon(
                        bgColor: blueDarkLight,
                        iconData: Icons.edit_outlined,
                        onTap: () {
                          _isEditCheck = true;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewChildPage(
                                        parentDataModel: parentDataModel,
                                        parentRef: widget.parentRef,
                                        userDataModel: widget.userDataModel,
                                        userModelReference:
                                            widget.userModelReference,
                                        childModel: childModel,
                                        childRef: childRef,
                                    isEditCheck: _isEditCheck,
                                      )));
                          _isEditEnabled = !_isEditEnabled;
                        },
                      ),
                    if (_isEditEnabled)
                      _getActionIcon(
                        bgColor: red,
                        iconData: Icons.delete_outline,
                        onTap: () {
                          _showDialogChildren(
                              childDataModel: childModel, childRef: childRef);
                          _isEditEnabled = !_isEditEnabled;
                        },
                      ),
                  ],
                ),
              );
            },
          );
        });
  }

  _showDialogChildren(
      {ChildModel? childDataModel, DocumentReference? childRef}) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.w)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(Constants.delete, style: logoutTextStyle),
            Icon(Icons.clear, color: red, size: 22.sp),
          ],
        ),
        content: Text(Constants.deleteSure, style: sizeTextStyle),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Padding(
              padding: EdgeInsets.only(left: 50.w),
              child: Text(Constants.no, style: NoTextStyle),
            ),
          ),
          TextButton(
            onPressed: () {
              String? getId = childDataModel?.id;
              childRef?.delete();
              widget.userDataModel.children.remove(getId);
              widget.parentDataModel.children.remove(getId);
              widget.userModelReference.update(widget.userDataModel.toJson());
              widget.parentRef.update(widget.parentDataModel.toJson());
              Navigator.pop(context);
            },
            child: Text(Constants.yes, style: YesTextStyle),
          )
        ],
      ),
    );
  }

  _getActionIcon({
    required Color bgColor,
    required IconData iconData,
    GestureTapCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.w),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          height: double.infinity,
          margin: EdgeInsets.all(4.w),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(14.w),
          ),
          child: Icon(
            iconData,
            color: white,
          ),
        ),
      ),
    );
  }

  _classesNameIcon(String name) {
    return SizedBox(
      height: 36.w,
      width: 36.w,
      child: Card(
        color: blueDarkLight2,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.w),
        ),
        child: Center(
          child: Text(
            '${name[0].toUpperCase()}',
            style: iconClassTextStyle,
          ),
        ),
      ),
    );
  }
}
