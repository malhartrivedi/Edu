import 'package:admin/model/user_data_model.dart';
import 'package:admin/service/firestore_methods.dart';
import 'package:admin/service/user_auth.dart';
import 'package:admin/utils/app_asset_path.dart';
import 'package:admin/utils/app_color.dart';
import 'package:admin/utils/constants.dart';
import 'package:admin/utils/global.dart';
import 'package:admin/widgets/my_textstyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final schoolController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final postController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool nameFocus = false;
  bool emailFocus = false;
  bool schoolFocus = false;
  bool phoneFocus = false;
  bool addressFocus = false;
  bool cityFocus = false;
  bool stateFocus = false;
  bool postFocus = false;
  bool passwordFocus = false;
  bool confirmFocus = false;
  bool passFocus = false;

  String get name => nameController.value.text;

  String get email => emailController.value.text;

  String get school => schoolController.value.text;

  String get phone => phoneController.value.text;

  String get address => addressController.value.text;

  String get city => cityController.value.text;

  String get state => stateController.value.text;

  String get post => postController.value.text;

  String get password => passwordController.value.text;

  String get confirmPassword => confirmPasswordController.value.text;

  onConfirms(String confirms) {
    setState(() {
      _isConfirmPass = false;
      if (password == confirmPassword) {
        _isConfirmPass = true;
      }
    });
  }

  String _password = '';
  bool _isVisible = false;
  bool _isConfirmVisible = false;
  bool _isConfirmPass = false;
  bool _isNameValid = false;
  bool _isEmailValid = false;
  bool _isSchoolValid = false;
  bool _isPhoneValid = false;
  bool _isAddressValid = false;
  bool _isCityValid = false;
  bool _isStateValid = false;
  bool _isPostValid = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: whiteOff,
        body: SafeArea(
          child: _getBody(),
        ),
      ),
    );
  }

  _getBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
      child: Column(
        children: [
          _iconTextDisplay(),
          SizedBox(height: 20),
          Text(
            Constants.registerToCon,
            style: h4TextStyle,
          ),
          SizedBox(height: 20.h),
          _nameTextField(),
          SizedBox(height: 16.h),
          _emailTextField(),
          SizedBox(height: 16.h),
          _schoolTextField(),
          SizedBox(height: 16.h),
          _phoneTextField(),
          SizedBox(height: 16.h),
          _addressTextField(),
          SizedBox(height: 16.h),
          _cityTextField(),
          SizedBox(height: 16.h),
          _stateTextField(),
          SizedBox(height: 16.h),
          _postTextField(),
          SizedBox(height: 16.h),
          _passwordTextField(),
          SizedBox(height: 16.h),
          _confirmTextField(),
          SizedBox(height: 36.h),
          _registerButton(),
          SizedBox(height: 36.h),
          _backToLogin(),
        ],
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

  _nameTextField() {
    return _getContainerOutLine(
      hasFocus: nameFocus == true,
      child: Focus(
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: nameController,
          keyboardType: TextInputType.text,
          style: h2TextStyle,
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.check,
              color: _isNameValid == true ? blueDark : grey,
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            labelText: Constants.name,
            labelStyle: TextStyle(
              color: greyDark,
            ),
          ),
          validator: (name) {
            if (name!.isEmpty) {
              _isNameValid = false;
              return Constants.enterName;
            } else if (name.trim().length < 3) {
              _isNameValid = true;
              return Constants.validName;
            }
            return null;
          },
        ),
        onFocusChange: (name) {
          setState(() {
            nameFocus = name;
          });
        },
      ),
    );
  }

  _emailTextField() {
    return _getContainerOutLine(
      hasFocus: emailFocus == true,
      child: Focus(
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          style: h2TextStyle,
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.email,
              color: _isEmailValid == true ? blueDark : grey,
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            labelText: Constants.email,
            labelStyle: TextStyle(
              color: greyDark,
            ),
          ),
          validator: (email) {
            if (email!.isEmpty) {
              _isEmailValid = false;
              return Constants.enterEmail;
            } else if (!RegExp(Constants.emailValidator).hasMatch(email)) {
              _isEmailValid = true;
              return Constants.validEmail;
            }
            return null;
          },
        ),
        onFocusChange: (email) {
          setState(() {
            emailFocus = email;
          });
        },
      ),
    );
  }

  _schoolTextField() {
    return _getContainerOutLine(
      hasFocus: schoolFocus == true,
      child: Focus(
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: schoolController,
          keyboardType: TextInputType.text,
          style: h2TextStyle,
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.check,
              color: _isSchoolValid == true ? blueDark : grey,
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            labelText: Constants.schoolName,
            labelStyle: TextStyle(
              color: greyDark,
            ),
          ),
          validator: (school) {
            if (school!.isEmpty) {
              _isSchoolValid = false;
              return Constants.enterSchool;
            } else if (school.isNotEmpty) {
              _isSchoolValid = true;
            }
            return null;
          },
        ),
        onFocusChange: (school) {
          setState(() {
            schoolFocus = school;
          });
        },
      ),
    );
  }

  _phoneTextField() {
    return _getContainerOutLine(
      hasFocus: phoneFocus == true,
      child: Focus(
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: phoneController,
          keyboardType: TextInputType.phone,
          style: h2TextStyle,
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.phone,
              color: _isPhoneValid == true ? blueDark : grey,
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            labelText: Constants.phone,
            labelStyle: TextStyle(
              color: greyDark,
            ),
          ),
          validator: (phone) {
            if (phone!.isEmpty) {
              _isPhoneValid = false;
              return Constants.enterPhone;
            } else if (phone.trim().length < 10) {
              _isPhoneValid = true;
              return Constants.validPhone;
            }
            return null;
          },
        ),
        onFocusChange: (phone) {
          setState(() {
            phoneFocus = phone;
          });
        },
      ),
    );
  }

  _addressTextField() {
    return _getContainerOutLine(
      hasFocus: addressFocus == true,
      child: Focus(
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: addressController,
          keyboardType: TextInputType.text,
          style: h2TextStyle,
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.home,
              color: _isAddressValid == true ? blueDark : grey,
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            labelText: Constants.address,
            labelStyle: TextStyle(
              color: greyDark,
            ),
          ),
          validator: (address) {
            if (address!.isEmpty) {
              _isAddressValid = false;
              return Constants.enterAddress;
            } else if (address.isNotEmpty) {
              _isAddressValid = true;
            }
            return null;
          },
        ),
        onFocusChange: (address) {
          setState(() {
            addressFocus = address;
          });
        },
      ),
    );
  }

  _cityTextField() {
    return _getContainerOutLine(
      hasFocus: cityFocus == true,
      child: Focus(
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: cityController,
          keyboardType: TextInputType.text,
          style: h2TextStyle,
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.check,
              color: _isCityValid == true ? blueDark : grey,
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            labelText: Constants.city,
            labelStyle: TextStyle(
              color: greyDark,
            ),
          ),
          validator: (city) {
            if (city!.isEmpty) {
              _isCityValid = false;
              return Constants.enterCity;
            } else if (city.isNotEmpty) {
              _isCityValid = true;
            }
            return null;
          },
        ),
        onFocusChange: (city) {
          setState(() {
            cityFocus = city;
          });
        },
      ),
    );
  }

  _stateTextField() {
    return _getContainerOutLine(
      hasFocus: stateFocus == true,
      child: Focus(
        child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: stateController,
            keyboardType: TextInputType.text,
            style: h2TextStyle,
            decoration: InputDecoration(
              suffixIcon: Icon(
                Icons.check,
                color: _isStateValid == true ? blueDark : grey,
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              labelText: Constants.state,
              labelStyle: TextStyle(
                color: greyDark,
              ),
            ),
            validator: (state) {
              if (state!.isEmpty) {
                _isStateValid = false;
                return Constants.enterState;
              } else if (state.isNotEmpty) {
                _isStateValid = true;
              }
              return null;
            }),
        onFocusChange: (state) {
          setState(() {
            stateFocus = state;
          });
        },
      ),
    );
  }

  _postTextField() {
    return _getContainerOutLine(
      hasFocus: postFocus == true,
      child: Focus(
        child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: postController,
            keyboardType: TextInputType.number,
            style: h2TextStyle,
            decoration: InputDecoration(
              suffixIcon: Icon(
                Icons.check,
                color: _isPostValid == true ? blueDark : grey,
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              labelText: Constants.post,
              labelStyle: TextStyle(
                color: greyDark,
              ),
            ),
            validator: (post) {
              if (post!.isEmpty) {
                _isPostValid = false;
                return Constants.enterPost;
              } else if (post.isNotEmpty) {
                _isPostValid = true;
              }
              return null;
            }),
        onFocusChange: (post) {
          setState(() {
            postFocus = post;
          });
        },
      ),
    );
  }

  _passwordTextField() {
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
        onFocusChange: (password) {
          setState(() {
            passwordFocus = password;
          });
        },
      ),
    );
  }

  _confirmTextField() {
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

  _registerButton() {
    return ElevatedButton(
      onPressed: () {
        if (!formKey.currentState!.validate()) {
          return;
        }
        _registerUser();
      },
      style: ElevatedButton.styleFrom(
        primary: blueDarkLight,
        minimumSize: Size.fromHeight(60.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Text(Constants.register),
    );
  }

  _backToLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Constants.already,
          style: h3TextStyle,
        ),
        SizedBox(width: 4),
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Text(
            Constants.login,
            style: h5TextStyle,
          ),
        ),
      ],
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

  _registerUser() async {
    try {
      UserCredential userCred = await UserAuth().userSignUp(
        email: email,
        password: password,
      );
      Navigator.of(context).pop();
      UserDataModel model = UserDataModel(
        uid: userCred.user!.uid,
        name: name,
        email: email,
        phone: int.parse(phone),
        address: address,
        city: city,
        state: state,
        instituteId: Global.getUniqueCode(),
        school: school,
        post: int.parse(post),
      );

      await FirestoreMethods().addData(UserType.Admin, model.toJson());
    } catch (e) {
      Global.showSnackBar(context, e.toString());
    }
  }
}
