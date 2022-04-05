import 'package:admin/model/user_data_model.dart';
import 'package:admin/service/firestore_methods.dart';
import 'package:admin/utils/app_asset_path.dart';
import 'package:admin/utils/app_color.dart';
import 'package:admin/utils/app_icon.dart';
import 'package:admin/utils/constants.dart';
import 'package:admin/views/home/parent/parent_page.dart';
import 'package:admin/views/home/teacher/teacher_page.dart';
import 'package:admin/widgets/my_textstyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formKey = GlobalKey<FormState>();
  final classController = TextEditingController();

  String get classes => classController.value.text;
  bool ClassFocus = false;
  bool _isClassValid = false;
  bool _isEditEnabled = false;
  UserDataModel? _userDataModel;

  Future<void> _getUserData() async {
    final QuerySnapshot<UserDataModel> data =
        await FirestoreMethods().getAdminByUID(widget.uid).get();

    setState(() {
      _userDataModel = data.docs.first.data();
    });
  }

  @override
  void initState() {
    _getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: _getAppBar(),
        body: AbsorbPointer(
          absorbing: _userDataModel == null,
          child: _getBody(),
        ),
      ),
    );
  }

  _getAppBar() {
    return AppBar(
      backgroundColor: whiteOff,
      centerTitle: false,
      titleSpacing: 12.w,
      elevation: 0.7,
      title: Row(
        children: [
          SizedBox(
            height: 46.w,
            width: 46.w,
            child: Card(
              color: greyWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.w),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(AssetPath.iconSchool),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          if (_userDataModel != null)
            Text(_userDataModel!.school, style: schoolTextStyle),
        ],
      ),
    );
  }

  _getBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Column(
        children: [
          Row(
            children: [
              _getTeacherParentItem(
                label: Constants.teacher,
                assetPath: AssetPath.iconTeacher,
                onTap: _goToTeacherPage,
              ),
              SizedBox(width: 10.w),
              _getTeacherParentItem(
                label: Constants.parent,
                assetPath: AssetPath.iconFamily,
                onTap: _goToParentPage,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          _getClasses(),
        ],
      ),
    );
  }

  _goToTeacherPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TeacherPage(
          adminData: _userDataModel!,
        ),
      ),
    );
  }

  _goToParentPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ParentPage(
          adminDataParent: _userDataModel!,
        ),
      ),
    );
  }

  _getClasses() {
    return Card(
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
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.w)),
            ),
            child: Row(
              children: [
                SizedBox(width: 2.w),
                Container(
                  width: 38.w,
                  height: 38.w,
                  padding: EdgeInsets.all(6.w),
                  margin: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: greyGr,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Image.asset(AssetPath.iconBlackBoard),
                ),
                SizedBox(width: 4.w),
                Text(Constants.classes, style: blueDark20BoldTS),
                Spacer(),
                InkWell(
                  onTap: () => _getBottomSheet(),
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
                      _isEditEnabled ? Icons.clear : Icons.edit_outlined,
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
    );
  }

  _getTeacherParentItem(
      {required String label,
      required String assetPath,
      GestureTapCallback? onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.w),
        child: Card(
          elevation: 5,
          color: greyWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.w),
          ),
          child: Padding(
            padding: EdgeInsets.all(6.w),
            child: Column(
              children: [
                Image.asset(assetPath, height: 100.h),
                Text(
                  label,
                  style: teacherTextStyle,
                ),
                SizedBox(height: 6.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getBottomSheet() {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: whiteOff,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 24.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Constants.createClass,
                        style: classTextStyle,
                      ),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.close),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: blueDarkLight2, height: 1),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 16.h,
                  ),
                  child: Column(
                    children: [
                      _createClassesTextField(),
                      SizedBox(height: 12.h),
                      _submitButton(),
                      SizedBox(height: 8.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _createClassesTextField() {
    return _getContainerOutLine(
      hasFocus: ClassFocus == true,
      child: Focus(
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: classController,
          keyboardType: TextInputType.text,
          style: h2TextStyle,
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.check,
              color: _isClassValid == true ? blueDark : grey,
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            labelText: Constants.classes,
            labelStyle: TextStyle(
              color: greyDark,
            ),
          ),
          validator: (name) {
            if (name!.isEmpty) {
              _isClassValid = false;
              return Constants.enterName;
            } else if (name.trim().length < 6) {
              _isClassValid = true;
              return Constants.validName;
            }
            return null;
          },
        ),
        onFocusChange: (name) {
          setState(() {
            ClassFocus = name;
          });
        },
      ),
    );
  }

  _submitButton() {
    return ElevatedButton(
      onPressed: () {
        if (!formKey.currentState!.validate()) {
          return;
        } else if (classController.text.isNotEmpty) {
          return Navigator.pop(context);
        }
      },
      style: ElevatedButton.styleFrom(
        primary: greyGreenDarkLight,
        minimumSize: Size.fromHeight(50.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(Constants.submit),
    );
  }

  _getContainerOutLine({required Widget child, required bool hasFocus}) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: greyLight30,
        borderRadius: BorderRadius.all(Radius.circular(14.w)),
        border: Border.all(color: hasFocus ? blueDark : white),
      ),
      child: child,
    );
  }

  _getClassesListView() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      primary: false,
      shrinkWrap: true,
      itemCount: 3,
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
      itemBuilder: (context, index) {
        return IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                      border: Border.all(color: blueDarkLight3),
                      borderRadius: BorderRadius.circular(14.w)),
                  child: Row(
                    children: [
                      _classesNameIcon(),
                      SizedBox(width: 6.w),
                      Text(
                        Constants.classList,
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
                  onTap: () {},
                ),
              if (_isEditEnabled)
                _getActionIcon(
                  bgColor: red,
                  iconData: Icons.delete_outline,
                  onTap: () {},
                ),
            ],
          ),
        );
      },
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

  _classesNameIcon() {
    var Firstname = Constants.classList;
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
            '${Firstname[0].toUpperCase()}',
            style: iconClassTextStyle,
          ),
        ),
      ),
    );
  }
}
