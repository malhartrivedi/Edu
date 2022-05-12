import 'package:admin/utils/app_color.dart';
import 'package:admin/utils/constants.dart';
import 'package:admin/widgets/my_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  final passwordController = TextEditingController();
  final passwordNewController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String get password => passwordController.value.text;
  String get passwordNew => passwordNewController.value.text;
  String get confirmPassword => confirmPasswordController.value.text;


  final formKey = GlobalKey<FormState>();

  bool passwordFocus = false;
  bool passwordNewFocus = false;
  bool confirmFocus = false;
  bool passFocus = false;

  String _password = '';
  bool _isVisible = false;
  bool _isNewVisible = false;
  bool _isConfirmVisible = false;
  bool _isConfirmPass = false;

  onConfirms(String confirms) {
    setState(() {
      _isConfirmPass = false;
      if (passwordNew == confirmPassword) {
        _isConfirmPass = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(Constants.changePasswordSmall),
          backgroundColor: blueDarkLight2,
        ),
        body: SafeArea(
          child: _getPasswordBody(),
        ),
        backgroundColor: whiteOff,
      ),
    );
  }


  _getPasswordBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 16.h,horizontal: 24.w),
      child: Column(
        children: [
          SizedBox(height: 16.h),
          _getPassword(),
          SizedBox(height: 16.h),
          _getNewPassword(),
          SizedBox(height: 16.h),
          _getConfirmPassword(),
          SizedBox(height: 24.h),
          _onSubmit(),
        ],
      ),
    );
  }

  _getPassword() {
    return _getContainerOutLine(
      hasFocus: passwordFocus == true,
      child: Focus(
        child: TextFormField(
          controller: passwordController,
          obscureText: !_isVisible,
          onChanged: (password) => _password = password,
          keyboardType: TextInputType.visiblePassword,
          style: h2TextStyle,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isVisible = !_isVisible;
                });
              },
              icon: Icon(
                _isVisible ? Icons.visibility : Icons.visibility_off,
                color: _isVisible ? Colors.black : Colors.grey,
              ),
            ),
            contentPadding:
            EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            labelText: Constants.oldPassword,
            labelStyle: TextStyle(
              color: greyDark,
            ),
          ),
          validator: (password) {
            if (password!.isEmpty) {
              return Constants.enterPassword;
            } else if (password.trim().length < 6) {
              return Constants.validPassword;
            }
            return null;
          },
        ),
        onFocusChange: (password) {
          setState(() {
            passwordFocus = password;
          });
        },
      ),
    );
  }

  _getNewPassword() {
    return _getContainerOutLine(
      hasFocus: passwordNewFocus == true,
      child: Focus(
        child: TextFormField(
          controller: passwordNewController,
          obscureText: !_isNewVisible,
          onChanged: (password) => _password = password,
          keyboardType: TextInputType.visiblePassword,
          style: h2TextStyle,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isNewVisible = !_isNewVisible;
                });
              },
              icon: Icon(
                _isNewVisible ? Icons.visibility : Icons.visibility_off,
                color: _isNewVisible ? Colors.black : Colors.grey,
              ),
            ),
            contentPadding:
            EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            labelText: Constants.newPassword,
            labelStyle: TextStyle(
              color: greyDark,
            ),
          ),
          validator: (password) {
            if (password!.isEmpty) {
              return Constants.enterPassword;
            } else if (password.trim().length < 6) {
              return Constants.validPassword;
            }
            return null;
          },
        ),
        onFocusChange: (password) {
          setState(() {
            passwordNewFocus = password;
          });
        },
      ),
    );
  }

  _getConfirmPassword() {
    return _getContainerOutLine(
      hasFocus: confirmFocus,
      child: Focus(
        child: TextFormField(
          controller: confirmPasswordController,
          obscureText: !_isConfirmVisible,
          onChanged: (confirms) => onConfirms(confirms),
          keyboardType: TextInputType.visiblePassword,
          style: h2TextStyle,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.check,
                color: _isConfirmPass ? blueDark : Colors.grey),
            contentPadding:
            EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            labelText: Constants.confirmPassword,
            labelStyle: TextStyle(
              color: greyDark,
            ),
          ),
          validator: (Confirm) {
            if (Confirm!.isEmpty) {
              return Constants.enterPassword;
            } else if (Confirm != _password) {
              return Constants.validConfirmPassword;
            }
            return null;
          },
        ),
        onFocusChange: (confirm) {
          setState(() {
            confirmFocus = confirm;
          });
        },
      ),
    );
  }

  _onSubmit(){
    return ElevatedButton(
      onPressed: () {
        if (!formKey.currentState!.validate()) {
          return;
        }
      },
      style: ElevatedButton.styleFrom(
        primary: greyGreenDarkLight,
        minimumSize: Size.fromHeight(60.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
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
}
