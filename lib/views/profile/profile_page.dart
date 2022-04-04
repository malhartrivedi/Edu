import 'package:admin/model/user_data_model.dart';
import 'package:admin/service/user_auth.dart';
import 'package:admin/utils/app_color.dart';
import 'package:admin/utils/app_icon.dart';
import 'package:admin/utils/constants.dart';
import 'package:admin/utils/global.dart';
import 'package:admin/views/profile/change_password_page.dart';
import 'package:admin/views/profile/edit_profile_page.dart';
import 'package:admin/widgets/my_textstyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key, required this.uid}) : super(key: key);
  final uid;



  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
    return StreamBuilder<QuerySnapshot<UserDataModel>>(
      stream: _getData(widget.uid),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        final data = snapshot.requireData;
        UserDataModel model = data.docs.first.data();
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
                      '${model.name[0].toUpperCase()}',
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
              Text('${model.name}', style: ThemeNameBoldTextStyle),
              Text('${model.email}', style: ThemeEmailBoldTextStyle),
              SizedBox(height: 32.h),
              _getDivider(),
              _getDetailItem(Constants.phoneB, '+91-${model.phone}'),
              _getDivider(),
              _getDetailItem(Constants.schoolB, '${model.school}'),
              _getDivider(),
              _getDetailItem(Constants.addressB, '${model.address}'),
              _getDivider(),
              _getDetailItem(Constants.cityB, '${model.city}'),
              _getDivider(),
              _getDetailItem(Constants.stateB, '${model.state}'),
              _getDivider(),
              _getDetailItem(Constants.postB, '${model.post}'),
              _getDivider(),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfile(userModel: model),
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
                          Constants.editProfile,
                          textAlign: TextAlign.center,
                          style: sizeWhiteTextStyle,
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangePassword(),
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
                          Constants.changePassword,
                          textAlign: TextAlign.center,
                          style: sizeWhiteTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: ElevatedButton(
                    onPressed: () => _showDialog(),
                    style: ElevatedButton.styleFrom(
                      elevation: 6.0,
                      primary: greyWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      Constants.logoutB,
                      style: logTextStyle,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Stream<QuerySnapshot<UserDataModel>>? _getData(String uid) {
    Stream<QuerySnapshot<UserDataModel>>? stream = FirebaseFirestore.instance
        .collection('users')
        .doc('users')
        .collection('admin')
        .where('uid', isEqualTo: uid)
        .withConverter<UserDataModel>(
            fromFirestore: (snapshots, _) =>
                UserDataModel.fromJson(snapshots.data()!),
            toFirestore: (UserDataModel, _) => UserDataModel.toJson())
        .snapshots();
    return stream;
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
            Text(Constants.logout, style: logoutTextStyle),
            Icon(icLogout, color: redLight, size: 22.sp),
          ],
        ),
        content: Text(Constants.logoutSure, style: sizeTextStyle),
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
              Navigator.pop(context);
              _logout();
            },
            child: Text(Constants.yes, style: YesTextStyle),
          )
        ],
      ),
    );
  }

  _logout() {
    try {
      UserAuth().logout();
    } catch (e) {
      Global.showSnackBar(context, e.toString());
    }
  }
}
