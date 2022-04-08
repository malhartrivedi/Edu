import 'package:admin/model/user_data_model.dart';
import 'package:admin/service/user_auth.dart';
import 'package:admin/utils/app_asset_path.dart';
import 'package:admin/utils/app_color.dart';
import 'package:admin/utils/constants.dart';
import 'package:admin/utils/global.dart';
import 'package:admin/widgets/my_textstyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key, required this.userModel, required this.reference})
      : super(key: key);
  UserDataModel userModel;
  DocumentReference reference;

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    nameController.text = widget.userModel.name;
    emailController.text = widget.userModel.email;
    schoolController.text = widget.userModel.school;
    phoneController.text = widget.userModel.phone.toString();
    addressController.text = widget.userModel.address;
    cityController.text = widget.userModel.city;
    stateController.text = widget.userModel.state;
    postController.text = widget.userModel.post.toString();
  }

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final schoolController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final postController = TextEditingController();

  String get name => nameController.value.text;

  String get email => emailController.value.text;

  String get school => schoolController.value.text;

  String get phone => phoneController.value.text;

  String get address => addressController.value.text;

  String get city => cityController.value.text;

  String get state => stateController.value.text;

  String get post => postController.value.text;

  bool nameFocus = false;
  bool emailFocus = false;
  bool schoolFocus = false;
  bool phoneFocus = false;
  bool addressFocus = false;
  bool cityFocus = false;
  bool stateFocus = false;
  bool postFocus = false;

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
        appBar: AppBar(
          title: Text(Constants.editProfile, style: ExtraBoldTextStyle),
          backgroundColor: blueDarkLight2,
        ),
        body: SafeArea(
          child: _getProfileBody(),
        ),
        backgroundColor: whiteOff,
      ),
    );
  }

  _getProfileBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
      child: Column(
        children: [
          nameTextField,
          _sizedHeight,
          emailTextField,
          _sizedHeight,
          schoolTextField,
          _sizedHeight,
          phoneTextField,
          _sizedHeight,
          addressTextField,
          _sizedHeight,
          cityTextField,
          _sizedHeight,
          stateTextField,
          _sizedHeight,
          postTextField,
          SizedBox(height: 20.h),
          _submitButton(),
        ],
      ),
    );
  }

  Widget get _sizedHeight => SizedBox(height: 16.h);

  Widget get nameTextField => getTextFormField(nameController,
          label: Constants.name,
          hasFocus: nameFocus,
          isValid: _isNameValid,
          suffixIcon: Icons.check,
          validator: nameValidator, onFocusChange: (nameFoc) {
        setState(() {
          nameFocus = nameFoc;
        });
      });

  String? nameValidator(String? value) {
    if (name.isEmpty) {
      _isNameValid = false;
      return Constants.enterName;
    } else if (name.trim().length < 3) {
      _isNameValid = true;
      return Constants.validName;
    }
    return null;
  }

  Widget get emailTextField => getTextFormField(emailController,
          label: Constants.email,
          hasFocus: emailFocus,
          isValid: _isEmailValid,
          suffixIcon: Icons.email,
          readOnly: true,
          validator: emailValidator, onFocusChange: (emailFoc) {
        setState(() {
          emailFocus = emailFoc;
        });
      });

  String? emailValidator(String? value) {
    if (value!.isEmpty) {
      _isEmailValid = false;
      return Constants.enterEmail;
    } else if (!RegExp(Constants.emailValidator).hasMatch(value)) {
      _isEmailValid = true;
      return Constants.invalidEmail;
    }
    return null;
  }

  Widget get schoolTextField => getTextFormField(phoneController,
          label: Constants.school,
          hasFocus: schoolFocus,
          isValid: _isSchoolValid,
          suffixIcon: Icons.check,
          validator: schoolValidator, onFocusChange: (schoolFoc) {
        setState(() {
          schoolFocus = schoolFoc;
        });
      });

  String? schoolValidator(String? value) {
    if (school.isEmpty) {
      _isSchoolValid = false;
      return Constants.enterSchool;
    } else if (school.isNotEmpty) {
      _isSchoolValid = true;
    }
    return null;
  }

  Widget get phoneTextField => getTextFormField(phoneController,
          label: Constants.phone,
          hasFocus: phoneFocus,
          isValid: _isPhoneValid,
          suffixIcon: Icons.phone,
          validator: phoneValidator, onFocusChange: (phoneFoc) {
        setState(() {
          phoneFocus = phoneFoc;
        });
      });

  String? phoneValidator(String? value) {
    if (value!.isEmpty) {
      _isPhoneValid = false;
      return Constants.enterPhone;
    } else if (phone.trim().length < 10) {
      _isPhoneValid = true;
      return Constants.validPhone;
    }
    return null;
  }

  Widget get addressTextField => getTextFormField(addressController,
          label: Constants.address,
          hasFocus: addressFocus,
          isValid: _isPhoneValid,
          suffixIcon: Icons.home,
          validator: addressValidator, onFocusChange: (addressFoc) {
        setState(() {
          addressFocus = addressFoc;
        });
      });

  String? addressValidator(String? value) {
    if (value!.isEmpty) {
      _isAddressValid = false;
      return Constants.enterAddress;
    } else if (address.isNotEmpty) {
      _isAddressValid = true;
    }
    return null;
  }

  Widget get cityTextField => getTextFormField(cityController,
          label: Constants.city,
          hasFocus: cityFocus,
          isValid: _isCityValid,
          suffixIcon: Icons.check,
          validator: cityValidator, onFocusChange: (cityFoc) {
        setState(() {
          cityFocus = cityFoc;
        });
      });

  String? cityValidator(String? value) {
    if (city.isEmpty) {
      _isCityValid = false;
      return Constants.enterCity;
    } else if (city.isNotEmpty) {
      _isCityValid = true;
    }
    return null;
  }

  Widget get stateTextField => getTextFormField(stateController,
          label: Constants.state,
          hasFocus: stateFocus,
          isValid: _isStateValid,
          suffixIcon: Icons.check,
          validator: stateValidator, onFocusChange: (stateFoc) {
        setState(() {
          stateFocus = stateFoc;
        });
      });

  String? stateValidator(String? value) {
    if (value!.isEmpty) {
      _isStateValid = false;
      return Constants.enterState;
    } else if (state.isNotEmpty) {
      _isStateValid = true;
    }
    return null;
  }

  Widget get postTextField => getTextFormField(postController,
          label: Constants.post,
          hasFocus: postFocus,
          isValid: _isPostValid,
          suffixIcon: Icons.check,
          validator: postValidator, onFocusChange: (postFoc) {
        setState(() {
          postFocus = postFoc;
        });
      });

  String? postValidator(String? value) {
    if (value!.isEmpty) {
      _isPostValid = false;
      return Constants.enterPost;
    } else if (post.isNotEmpty) {
      _isPostValid = true;
    }
    return null;
  }

  _submitButton() {
    return ElevatedButton(
      onPressed: () {
        if (!formKey.currentState!.validate()) {
          return;
        }
        _getEditProfile();
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

  _getEditProfile() async {
    UserDataModel userDataModel = UserDataModel(
      uid: widget.userModel.uid,
      name: name,
      email: email,
      phone: int.parse(phone),
      address: address,
      city: city,
      state: state,
      instituteId: widget.userModel.instituteId,
      post: int.parse(post),
      school: school,
      classes: widget.userModel.classes,
      children: widget.userModel.children,
      createdAt: widget.userModel.createdAt,
      updatedAt: DateTime.now(),
    );
    await widget.reference.update(userDataModel.toJson());
    Navigator.pop(context);
  }

  getTextFormField(
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
