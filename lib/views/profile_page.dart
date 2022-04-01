import 'package:admin/service/user_auth.dart';
import 'package:admin/utils/app_color.dart';
import 'package:admin/utils/app_icon.dart';
import 'package:admin/utils/constants.dart';
import 'package:admin/views/change_password_page.dart';
import 'package:admin/views/edit_profile_page.dart';
import 'package:admin/utils/global.dart';
import 'package:admin/widgets/my_textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var Firstname = Constants.NameInitial;
    return SafeArea(
      child: SingleChildScrollView(
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
                    '${Firstname[0].toUpperCase()}',
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
            Text(Constants.NameInitial, style: ThemeNameBoldTextStyle),
            Text(Constants.NameEmail, style: ThemeEmailBoldTextStyle),
            SizedBox(height: 32.h),
            _getDivider(),
            _getDetailItem(Constants.phoneB, '+91-9377726819'),
            _getDivider(),
            _getDetailItem(Constants.schoolB, 'CN High School'),
            _getDivider(),
            _getDetailItem(
                Constants.addressB, '14, Sai-Niketan Society-1 Vastral Road'),
            _getDivider(),
            _getDetailItem(Constants.cityB, 'Ahmedabad'),
            _getDivider(),
            _getDetailItem(Constants.stateB, 'Gujarat'),
            _getDivider(),
            _getDetailItem(Constants.postB, '380058'),
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
                          builder: (context) => EditProfile(),
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
                        style: sizeWhiteTextStyle,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
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
