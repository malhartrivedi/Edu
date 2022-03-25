import 'package:admin/utils/app_asset_path.dart';
import 'package:admin/utils/app_color.dart';
import 'package:admin/utils/constants.dart';
import 'package:admin/widgets/my_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class admin_Registration extends StatefulWidget {
  const admin_Registration({Key? key}) : super(key: key);

  @override
  _admin_RegistrationState createState() => _admin_RegistrationState();
}

class _admin_RegistrationState extends State<admin_Registration> {
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

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  onConfirms(String confirms) {
    setState(() {
      _isConfirmPass = false;
      if (passwordController.text == confirmController.text) {
        _isConfirmPass = true;
      }
    });
  }

/*  onName(String name){
    setState(() {
      _isNameValid = false;
      if(nameController.text == ){
        _isNameValid = true;
      }
    });
  }*/

  String _password = '';
  bool _isVisible = false;
  bool _isConfirmVisible = false;
  bool _isConfirmPass = false;
  bool _isNameValid = false;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: whiteOff,
          body: _getBody(),
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
          _RegisterButton(),
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
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: greyLight30,
        borderRadius: BorderRadius.all(Radius.circular(14.w)),
        border: Border.all(color: nameFocus == true ? blueDark : white),
      ),
      child: Focus(
        child: TextFormField(
          //onChanged: (name) => onName(name),
          keyboardType: TextInputType.text,
          style: h2TextStyle,
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.check,
              color: _isNameValid ? greyDark : grey,
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
              return Constants.enterName;
            } else if (name.trim().length < 3) {
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
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: greyLight30,
        borderRadius: BorderRadius.all(Radius.circular(14.w)),
        border: Border.all(color: emailFocus == true ? blueDark : white),
      ),
      child: Focus(
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          style: h2TextStyle,
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.email,
              color: greyDark,
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
              return Constants.enterEmail;
            } else if (!RegExp(Constants.emailValidator).hasMatch(email)) {
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
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: greyLight30,
        borderRadius: BorderRadius.all(Radius.circular(14.w)),
        border: Border.all(color: schoolFocus == true ? blueDark : white),
      ),
      child: Focus(
        child: TextFormField(
          keyboardType: TextInputType.text,
          style: h2TextStyle,
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.check,
              color: greyDark,
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
              return Constants.enterSchool;
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
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: greyLight30,
        borderRadius: BorderRadius.all(Radius.circular(14.w)),
        border: Border.all(color: phoneFocus == true ? blueDark : white),
      ),
      child: Focus(
        child: TextFormField(
          keyboardType: TextInputType.text,
          style: h2TextStyle,
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.phone,
              color: greyDark,
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
              return Constants.enterPhone;
            } else if (phone.trim().length < 10) {
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
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: greyLight30,
        borderRadius: BorderRadius.all(Radius.circular(14.w)),
        border: Border.all(color: addressFocus == true ? blueDark : white),
      ),
      child: Focus(
        child: TextFormField(
          keyboardType: TextInputType.text,
          style: h2TextStyle,
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.home,
              color: greyDark,
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
              return Constants.enterAddress;
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
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: greyLight30,
        borderRadius: BorderRadius.all(Radius.circular(14.w)),
        border: Border.all(color: cityFocus == true ? blueDark : white),
      ),
      child: Focus(
        child: TextFormField(
          keyboardType: TextInputType.text,
          style: h2TextStyle,
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.check,
              color: greyDark,
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
              return Constants.enterCity;
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
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: greyLight30,
        borderRadius: BorderRadius.all(Radius.circular(14.w)),
        border: Border.all(color: stateFocus == true ? blueDark : white),
      ),
      child: Focus(
        child: TextFormField(
            keyboardType: TextInputType.text,
            style: h2TextStyle,
            decoration: InputDecoration(
              suffixIcon: Icon(
                Icons.check,
                color: greyDark,
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
                return Constants.enterState;
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
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: greyLight30,
        borderRadius: BorderRadius.all(Radius.circular(14.w)),
        border: Border.all(color: postFocus == true ? blueDark : white),
      ),
      child: Focus(
        child: TextFormField(
            keyboardType: TextInputType.number,
            style: h2TextStyle,
            decoration: InputDecoration(
              suffixIcon: Icon(
                Icons.check,
                color: greyDark,
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
                return Constants.enterPost;
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
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: greyLight30,
        borderRadius: BorderRadius.all(Radius.circular(14.w)),
        border: Border.all(color: passwordFocus == true ? blueDark : white),
      ),
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
              icon: _isVisible
                  ? const Icon(
                      Icons.visibility,
                      color: Colors.black,
                    )
                  : const Icon(
                      Icons.visibility_off,
                      color: Colors.grey,
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
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: greyLight30,
        borderRadius: BorderRadius.all(Radius.circular(14.w)),
        border: Border.all(color: confirmFocus == true ? blueDark : white),
      ),
      child: Focus(
        child: TextFormField(
          controller: confirmController,
          obscureText: !_isConfirmVisible,
          onChanged: (confirms) => onConfirms(confirms),
          keyboardType: TextInputType.visiblePassword,
          style: h2TextStyle,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.check,
                color: _isConfirmPass ? greenLight : Colors.grey),
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

  _RegisterButton() {
    return ElevatedButton(
      onPressed: () {
        if (!formKey.currentState!.validate()) {
          return;
        }
        setState(() {
          Navigator.pop(context, formKey);
        });
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
}
