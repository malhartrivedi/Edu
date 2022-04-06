import 'package:admin/model/parent_data_model.dart';
import 'package:admin/utils/app_color.dart';
import 'package:admin/utils/constants.dart';
import 'package:admin/widgets/my_textstyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ParentEditPage extends StatefulWidget {
  ParentEditPage({Key? key,required this.model,this.reference}) : super(key: key);
  ParentDataModel model;
  DocumentReference? reference;

  @override
  _ParentEditPageState createState() => _ParentEditPageState();
}

class _ParentEditPageState extends State<ParentEditPage> {

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _instituteNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _postController = TextEditingController();
  String get name => _nameController.value.text;

  String get email => _emailController.value.text;

  String get instituteName => _instituteNameController.value.text;

  String get phone => _phoneController.value.text;

  String get address => _addressController.value.text;

  String get city => _cityController.value.text;

  String get state => _stateController.value.text;

  String get postCode => _postController.value.text;


  bool _nameFocus = false;
  bool _emailFocus = false;
  bool _instituteNameFocus = false;
  bool _phoneFocus = false;
  bool _addressFocus = false;
  bool _cityFocus = false;
  bool _stateFocus = false;
  bool _postFocus = false;

  bool _isNameValid = false;
  bool _isEmailValid = false;
  bool _isInstituteNameValid = false;
  bool _isPhoneValid = false;
  bool _isAddressValid = false;
  bool _isCityValid = false;
  bool _isStateValid = false;
  bool _isPostValid = false;

  @override
  void initState() {
    _nameController.text = widget.model.name!;
    _emailController.text = widget.model.email!;
    _phoneController.text = widget.model.phone.toString();
    _instituteNameController.text = widget.model.instituteName!;
    _addressController.text = widget.model.address!;
    _cityController.text = widget.model.city!;
    _stateController.text = widget.model.state!;
    _postController.text = widget.model.postcode.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(Constants.editParentProfile, style: ExtraBoldTextStyle),
          backgroundColor: blueDarkLight2,
        ),
        body: SafeArea(
          child: _getBody(),
        ),
        backgroundColor: whiteOff,
      ),
    );
  }

  _getBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        vertical: 16.h,
        horizontal: 24.w,
      ),
      child: Column(
        children: [
          _nameTextField,
          _sizedHeight,
          _emailTextField,
          _sizedHeight,
          _phoneTextField,
          _sizedHeight,
          _schoolTextField,
          _sizedHeight,
          _addressTextField,
          _sizedHeight,
          _cityTextField,
          _sizedHeight,
          _stateTextField,
          _sizedHeight,
          _postTextField,
          _sizedHeight,
          SizedBox(height: 4.h),
          _submitButton(),
        ],
      ),
    );
  }

  Widget get _sizedHeight => SizedBox(height: 16.h);

  Widget get _nameTextField => _getTextField(
    _nameController,
    label: Constants.name,
    hasFocus: _nameFocus,
    isValid: _isNameValid,
    suffixIcon: Icons.check,
    validator: nameValidator,
    onFocusChange: (haveFocus) {
      setState(() => _nameFocus = haveFocus);
    },
  );

  Widget get _emailTextField => _getTextField(
    _emailController,
    label: Constants.email,
    hasFocus: _emailFocus,
    isValid: _isEmailValid,
    suffixIcon: Icons.email,
    textInputType: TextInputType.emailAddress,
    validator: emailValidator,
    onFocusChange: (haveFocus) {
      setState(() => _emailFocus = haveFocus);
    },
  );

  Widget get _phoneTextField => _getTextField(
    _phoneController,
    label: Constants.phone,
    hasFocus: _phoneFocus,
    isValid: _isPhoneValid,
    suffixIcon: Icons.phone,
    textInputType: TextInputType.phone,
    validator: phoneValidator,
    onFocusChange: (haveFocus) {
      setState(() => _phoneFocus = haveFocus);
    },
  );

  Widget get _schoolTextField => _getTextField(
    _instituteNameController,
    label: Constants.schoolName,
    hasFocus: _instituteNameFocus,
    isValid: _isInstituteNameValid,
    readOnly: true,
    suffixIcon: Icons.check,
    onFocusChange: (haveFocus) {
      setState(() => _instituteNameFocus = haveFocus);
    },
  );

  Widget get _addressTextField => _getTextField(
    _addressController,
    label: Constants.address,
    hasFocus: _addressFocus,
    isValid: _isAddressValid,
    suffixIcon: Icons.home,
    validator: addressValidator,
    onFocusChange: (haveFocus) {
      setState(() => _addressFocus = haveFocus);
    },
  );

  Widget get _cityTextField => _getTextField(
    _cityController,
    label: Constants.city,
    hasFocus: _cityFocus,
    isValid: _isCityValid,
    suffixIcon: Icons.check,
    validator: cityValidator,
    onFocusChange: (haveFocus) {
      setState(() => _cityFocus = haveFocus);
    },
  );

  Widget get _stateTextField => _getTextField(
    _stateController,
    label: Constants.state,
    hasFocus: _stateFocus,
    isValid: _isStateValid,
    suffixIcon: Icons.check,
    validator: stateValidator,
    onFocusChange: (haveFocus) {
      setState(() => _stateFocus = haveFocus);
    },
  );

  Widget get _postTextField => _getTextField(
    _postController,
    label: Constants.post,
    textInputType: TextInputType.number,
    hasFocus: _postFocus,
    isValid: _isPostValid,
    suffixIcon: Icons.check,
    validator: postValidator,
    onFocusChange: (haveFocus) {
      setState(() => _postFocus = haveFocus);
    },
  );

  _submitButton() {
    return ElevatedButton(
      onPressed: () {
        if (!_formKey.currentState!.validate()) {
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
    ParentDataModel parentDataModel = ParentDataModel(
      uid: widget.model.uid,
      name: name,
      email: email,
      phone: int.parse(phone),
      instituteName: instituteName,
      address: address,
      city: city,
      state: state,
      postcode: int.parse(postCode),
    );
    await widget.reference?.update(parentDataModel.toJson());
    Navigator.pop(context);
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

  String? nameValidator(String? value) {
    if (value!.isEmpty) {
      _isNameValid = false;
      return Constants.enterName;
    } else if (value.trim().length < 3) {
      _isNameValid = true;
      return Constants.validName;
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value!.isEmpty) {
      _isEmailValid = false;
      return Constants.enterEmail;
    } else if (!RegExp(Constants.emailValidator).hasMatch(value)) {
      _isEmailValid = true;
      return Constants.validEmail;
    }
    return null;
  }

  String? phoneValidator(String? value) {
    if (value!.isEmpty) {
      _isPhoneValid = false;
      return Constants.enterPhone;
    } else if (value.trim().length < 10) {
      _isPhoneValid = true;
      return Constants.validPhone;
    }
    return null;
  }

  String? addressValidator(String? value) {
    if (value!.isEmpty) {
      _isAddressValid = false;
      return Constants.enterAddress;
    } else if (value.isNotEmpty) {
      _isAddressValid = true;
    }
    return null;
  }

  String? cityValidator(String? value) {
    if (value!.isEmpty) {
      _isCityValid = false;
      return Constants.enterCity;
    } else if (value.isNotEmpty) {
      _isCityValid = true;
    }
    return null;
  }

  String? stateValidator(String? value) {
    if (value!.isEmpty) {
      _isStateValid = false;
      return Constants.enterState;
    } else if (value.isNotEmpty) {
      _isStateValid = true;
    }
    return null;
  }

  String? postValidator(String? value) {
    if (value!.isEmpty) {
      _isPostValid = false;
      return Constants.enterPost;
    } else if (value.isNotEmpty) {
      _isPostValid = true;
    }
    return null;
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
}
