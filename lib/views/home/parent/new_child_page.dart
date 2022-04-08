import 'package:admin/utils/app_color.dart';
import 'package:admin/utils/constants.dart';
import 'package:admin/utils/global.dart';
import 'package:admin/widgets/my_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

enum Gender { Male, Female }

class NewChildPage extends StatefulWidget {
  const NewChildPage({Key? key}) : super(key: key);

  @override
  _NewChildPageState createState() => _NewChildPageState();
}

class _NewChildPageState extends State<NewChildPage> {
  int radioValue = -1;
  DateTime? _newDatePicker;
  DateTime? _getDate;
  String? _dateFormat;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dobController = TextEditingController();
  final _genderController = TextEditingController();

  String get name => _nameController.value.text;

  String get dob => _dobController.value.text;

  String get gender => _genderController.value.text;
  bool _nameFocus = false;
  bool _dateFocus = false;
  bool _isNameValid = false;
  bool _isDateValid = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            Constants.addNew,
            style: ExtraBoldTextStyle,
          ),
          backgroundColor: blueDarkLight2,
        ),
        backgroundColor: bgColor,
        body: _getBody(),
      ),
    );
  }

  _getBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
      child: Column(
        children: [
          _nameTextField,
          _sizedHeight,
          _dateOfBirthTextField,
          _sizedHeight,
          _genderTextField,
          _sizedHeight,
          _submitButton(),
        ],
      ),
    );
  }

  Widget get _dateOfBirthTextField {
    return _getContainerOutLine(
      hasFocus: _dateFocus == true,
      child: Focus(
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: _dobController,
          keyboardType: TextInputType.text,
          style: h2TextStyle,
          decoration: InputDecoration(
            suffixIcon: InkWell(
                onTap: _selectDate,
                child: Icon(
                  Icons.calendar_today_outlined,
                  color: _isDateValid == true ? blueDark : grey,
                )),
            contentPadding:
                EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            labelText: Constants.dateOfBirth,
            labelStyle: TextStyle(
              color: greyDark,
            ),
          ),
          validator: (date) {
            if (date!.isEmpty) {
              _isDateValid = false;
              return Constants.enterName;
            } else if (date.isNotEmpty) {
              _isDateValid = true;
            }
            return null;
          },
        ),
        onFocusChange: (date) {
          setState(() {
            _dateFocus = date;
          });
        },
      ),
    );
  }

  Widget get _genderTextField {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(Constants.gender, style: TextStyle(color: grey)),
        ),
        Row(
          children: [
            Expanded(
              child: RadioListTile<int>(
                  title: Text(Constants.male),
                  activeColor: greyGreenDark,
                  value: 1,
                  groupValue: radioValue,
                  onChanged: (value) {
                    setState(() {
                      radioValue = value!;
                    });
                  }),
            ),
            Expanded(
              child: RadioListTile<int>(
                  title: Text(Constants.female),
                  activeColor: greyGreenDark,
                  value: 2,
                  groupValue: radioValue,
                  onChanged: (value1) {
                    setState(() {
                      radioValue = value1!;
                    });
                  }),
            ),
          ],
        ),
      ],
    );
  }

  _selectDate() async {
    Text(_dateFormat == null ? Constants.selectDate : _dateFormat.toString());
    _newDatePicker = await showRoundedDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    ).then((date) {
      setState(() {
        _getDate = date;
        DateFormat formatter = DateFormat(Constants.dateFormat);
        _dateFormat = formatter.format(_getDate!);
        _dobController.text = _dateFormat.toString();
      });
      return null;
    });
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

  _submitButton() {
    return ElevatedButton(
      onPressed: () {
        if (!_formKey.currentState!.validate()) {
          return;
        } else if (radioValue < 0) {
          Global.showSnackBar(context, Constants.selectGender);
        } else {
          Navigator.pop(context);
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
