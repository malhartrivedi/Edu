import 'package:admin/model/class_model.dart';
import 'package:admin/service/firestore_methods.dart';
import 'package:admin/utils/app_color.dart';
import 'package:admin/utils/constants.dart';
import 'package:admin/widgets/my_textstyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ClassesDetailPage extends StatefulWidget {
  ClassesDetailPage({Key? key, required this.classModel, required this.classRef}) : super(key: key);

  ClassModel classModel;
  DocumentReference classRef;
  @override
  _ClassesDetailPageState createState() => _ClassesDetailPageState();
}

class _ClassesDetailPageState extends State<ClassesDetailPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: whiteOff,
          appBar: _getAppBar(),
          body: _getBody(),
        ),
      ),
    );
  }

  _getAppBar() {
    return AppBar(
      backgroundColor: blueDarkLight2,
      elevation: 6,
      title: _getClassName(),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      bottom: _getTabBar(),
    );
  }

  _getClassName() {
    return Row(
      children: [
        Text(
          '${widget.classModel.name}',
          style: ExtraBoldTextStyle,
        ),
      ],
    );
  }

  _getTabBar() {
    return TabBar(
      labelColor: white,
      indicatorColor: white,
      tabs: [
        Tab(text: Constants.home,),
        Tab(text: Constants.chat),
        Tab(text: Constants.lessons)
      ],
    );
  }

  _getBody() {
    return TabBarView(
      children: [
        Center(child: Text(Constants.home)),
        Center(child: Text(Constants.chat)),
        Center(child: Text(Constants.lessons)),
      ],
    );
  }
}
