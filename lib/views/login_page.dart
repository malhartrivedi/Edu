import 'package:admin/service/user_auth.dart';
import 'package:admin/utils/app_asset_path.dart';
import 'package:admin/utils/app_color.dart';
import 'package:admin/utils/constants.dart';
import 'package:admin/utils/global.dart';
import 'package:admin/views/registration_page.dart';
import 'package:admin/widgets/my_textstyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool _isVisible = false;
  bool _isEmail = false;
  bool emailFocus = false;
  bool passFocus = false;

  String get email => emailController.value.text;

  String get password => passwordController.value.text;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: whiteOff,
        body: _getBody(),
        bottomSheet: _bottomRegister(),
      ),
    );
  }

  _getBody() {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          children: [
            _iconTextDisplay(),
            SizedBox(height: 20.h),
            Text(
              Constants.signInCon,
              style: h4TextStyle,
            ),
            SizedBox(height: 30.h),
            emailTextField,
            SizedBox(height: 16.h),
            _passwordTextField(),
            SizedBox(height: 36.h),
            _SignInButton(),
          ],
        ),
      ),
    );
  }

  _iconTextDisplay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AssetPath.iconApp,
          alignment: Alignment.center,
          width: 56.w,
          height: 56.w,
        ),
        SizedBox(width: 12.w),
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: Text(
            Constants.appName,
            style: h1EBTextStyle,
          ),
        ),
      ],
    );
  }

  Widget get emailTextField => _getTextField(emailController,
      label: Constants.email,
      hasFocus: emailFocus,
      isValid: _isEmail,
      suffixIcon: Icons.email,
      validator: emailValidator, onFocusChange: (emailFoc) {
        setState(() {
          emailFocus = emailFoc;
        });
      });

  String? emailValidator(String? value) {
    if (value!.isEmpty) {
      _isEmail = false;
      return Constants.enterEmail;
    } else if (!RegExp(Constants.emailValidator).hasMatch(value)) {
      _isEmail = true;
      return Constants.invalidEmail;
    }
    return null;
  }

  _passwordTextField() {
    return Container(
      padding: EdgeInsets.all(8.h),
      decoration: BoxDecoration(
        color: greyLight30,
        borderRadius: BorderRadius.all(Radius.circular(14.w)),
        border: Border.all(color: passFocus == true ? blueDark : white),
      ),
      child: Focus(
        child: TextFormField(
          controller: passwordController,
          obscureText: !_isVisible,
          keyboardType: TextInputType.visiblePassword,
          style: h2TextStyle,
          decoration: InputDecoration(
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() => _isVisible = !_isVisible);
                },
                icon: Icon(
                  _isVisible ? Icons.visibility : Icons.visibility_off,
                  color: _isVisible ? Colors.black : Colors.grey,
                )),
            contentPadding: EdgeInsets.symmetric(
              vertical: 6.h,
              horizontal: 6.w,
            ),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            labelText: Constants.password,
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
        onFocusChange: (pass) {
          setState(() => passFocus = pass);
        },
      ),
    );
  }

  _SignInButton() {
    return ElevatedButton(
      onPressed: () {
        if (!formKey.currentState!.validate()) {
          return;
        }
        _getOnPressed();
      },
      style: ElevatedButton.styleFrom(
        primary: blueDarkLight,
        minimumSize: Size.fromHeight(60.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Text(Constants.signIn),
    );
  }

  _bottomRegister() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RegistrationPage(),
          ),
        );
      },
      child: Container(
        color: blueDarkLight,
        padding: EdgeInsets.only(bottom: 24.h, top: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              Constants.donT,
              style: h3WhiteTextStyle,
            ),
            SizedBox(width: 6.w),
            Text(
              Constants.register,
              style: h5WhiteTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  _clearField() {
    emailController.clear();
    passwordController.clear();
  }

  _getOnPressed() async {
    try {
      await UserAuth().userSignIn(
        email: email,
        password: password,
      );
      _clearField();
    } catch (e) {
      Global.showSnackBar(context, e.toString());
    }
  }

  _getTextField(
      TextEditingController controller, {
        required String label,
        required bool hasFocus,
        required bool isValid,
        required IconData suffixIcon,
        bool readOnly = false,
        TextInputType? textInputType,
        FormFieldValidator<String>? validator,
        ValueChanged<bool>? onFocusChange,
      }) {
    return _getContainerOutLine(
      hasFocus: hasFocus,
      child: Focus(
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          readOnly: readOnly,
          keyboardType: textInputType,
          style: h2TextStyle,
          decoration: InputDecoration(
            suffixIcon: Icon(
              suffixIcon,
              color: isValid ? blueDark : grey,
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 6.h,
              horizontal: 6.w,
            ),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            labelText: label,
            labelStyle: TextStyle(
              color: greyDark,
            ),
          ),
          validator: validator,
        ),
        onFocusChange: onFocusChange,
      ),
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
