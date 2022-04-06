import 'package:admin/model/parent_data_model.dart';
import 'package:admin/model/user_data_model.dart';
import 'package:admin/service/firestore_methods.dart';
import 'package:admin/utils/app_color.dart';
import 'package:admin/utils/app_icon.dart';
import 'package:admin/utils/constants.dart';
import 'package:admin/views/home/parent/parent_edit_page.dart';
import 'package:admin/widgets/my_textstyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ParentDetailPage extends StatefulWidget {
  ParentDetailPage({Key? key,required this.model,required this.reference}) : super(key: key);
  ParentDataModel model;
  DocumentReference reference;


  @override
  _ParentDetailPageState createState() => _ParentDetailPageState();
}

class _ParentDetailPageState extends State<ParentDetailPage> {
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
    ParentDataModel parentModel = widget.model;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50.h),
          SizedBox(
            height: 120.w,
            width: 120.w,
            child: Card(
              color: greyWhite,
              child: Center(
                child: Text(
                  '${parentModel.name![0].toUpperCase()}',
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
          Text('${parentModel.name}', style: ThemeNameBoldTextStyle),
          Text('${parentModel.email}', style: ThemeEmailBoldTextStyle),
          SizedBox(height: 32.h),
          _getDivider(),
          _getDetailItem(Constants.phoneB, '+91-${parentModel.phone}'),
          _getDivider(),
          _getDetailItem(Constants.schoolB, '${parentModel.instituteName}'),
          _getDivider(),
          _getDetailItem(Constants.addressB, '${parentModel.address}'),
          _getDivider(),
          _getDetailItem(Constants.cityB, '${parentModel.city}'),
          _getDivider(),
          _getDetailItem(Constants.stateB, '${parentModel.state}'),
          _getDivider(),
          _getDetailItem(Constants.postB, '${parentModel.postcode}'),
          _getDivider(),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ParentEditPage(model: parentModel,reference: widget.reference),
                      ),
                    ),
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
              widget.reference.delete();
              Navigator.pop(context);
            },
            child: Text(Constants.yes, style: YesTextStyle),
          )
        ],
      ),
    );
  }
}
