import 'package:admin/service/user_auth.dart';
import 'package:admin/utils/global.dart';
import 'package:flutter/material.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: _logout,
          child: Text('Logout'),
        ),
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
