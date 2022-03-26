import 'package:admin/utils/constants.dart';
import 'package:admin/views/dashboard_page.dart';
import 'package:admin/views/login_page.dart';
import 'package:admin/views/splash_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<bool> _waitForSplash() async {
    return await Future.delayed(Duration(seconds: 3), () => true);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: () => _getMaterialApp(),
    );
  }

  _getMaterialApp() => MaterialApp(
        title: Constants.appName,
        builder: (context, widget) {
          ScreenUtil.setContext(context);
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!,
          );
        },
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          initialData: null,
          future: _waitForSplash(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SplashPage();
            }
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const DashBoardPage();
                }
                return const LoginPage();
              },
            );
          },
        ),
      );
}
