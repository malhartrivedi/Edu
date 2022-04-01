import 'package:admin/service/user_auth.dart';
import 'package:admin/utils/app_color.dart';
import 'package:admin/utils/app_fonts.dart';
import 'package:admin/utils/app_icon.dart';
import 'package:admin/utils/constants.dart';
import 'package:admin/utils/global.dart';
import 'package:admin/views/home_page.dart';
import 'package:admin/views/profile_page.dart';
import 'package:admin/widgets/my_textstyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {

  bool iconHomeFocus = false;
  bool iconProfileFocus = false;


  int currentIndex = 0;
  final screens = [
    HomePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: blueDarkLight2,
        selectedItemColor: white,
        unselectedItemColor: greyGreenDarkLight,
        selectedLabelStyle: ExtraBoldTextStyle,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: <BottomNavigationBarItem>[
          _getBottomNavigationBarItem(0,icHomeFilled,icHome,Constants.home),
          _getBottomNavigationBarItem(1,icProfileFilled,icProfile,Constants.profile),
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

  _getBottomNavigationBarItem(int indexValue,IconData firstIcon,IconData secondIcon, String label){
    return BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.all(4),
        child: Icon(currentIndex == indexValue? firstIcon : secondIcon),
      ),
      label: label,
    );
  }
}
