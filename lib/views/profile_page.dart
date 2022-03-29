import 'package:admin/utils/app_color.dart';
import 'package:admin/utils/constants.dart';
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
                    'M',
                    style: ThemeBoldTextStyle,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(70.w),
                ),
                elevation: 6,
              ),
            ),
            SizedBox(height: 20.h),
            Text(Constants.Name, style: ThemeNameBoldTextStyle),
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
                      onPressed: (){},
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(greyGreenDarkLight)),
                      child: Text(
                        Constants.editProfile,
                        style: sizeTextStyle,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (){},
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(greyGreenDarkLight)),
                      child: Text(
                        Constants.changePassword,
                        style: sizeTextStyle,
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
                  onPressed: (){},
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(greyWhite)),
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
    return Divider(color: blueDarkLight2,height: 1);
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
}
