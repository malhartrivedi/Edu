import 'package:admin/utils/app_asset_path.dart';
import 'package:admin/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteOff,
      body: _getBody(),
    );
  }

  _getBody() {
    return Center(
      child: Image.asset(
        AssetPath.iconApp,
        width: 150.w,
        height: 150.w,
      ),
    );
  }
}
