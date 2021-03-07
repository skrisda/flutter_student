import 'package:flutter/material.dart';

class AppForm extends StatefulWidget {
  // ใช้สำหรับทำ form validations
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // ตรวจจับ text onchange
  TextEditingController fnameController;
  TextEditingController lnameController;
  TextEditingController telController;
  TextEditingController ageController;

  AppForm(
      {this.formKey,
      this.fnameController,
      this.lnameController,
      this.telController,
      this.ageController});

  @override
  _AppFormState createState() => _AppFormState();
}

class _AppFormState extends State<AppForm> {
  String _validateFname(String value) {
    if (value.length < 3) return 'First name must be 3 characters minimum';
  }

  String _validateLname(String value) {
    if (value.length < 3) return 'Last name must be 3 characters minimum';
  }

  String _validateTel(String value) {
    if (value.length < 9) return 'Telephone must be 9 characters minimum';
  }

  String _validateAge(String value) {
    // Regular Expressions for number
    Pattern pattern = r'(?<=\s|^)\d+(?=\s|$)';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) return 'Age must be a number';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          TextFormField(
            controller: widget.fnameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'First Name'),
            validator: _validateFname,
          ),
          TextFormField(
            controller: widget.lnameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Last Name'),
            validator: _validateLname,
          ),
          TextFormField(
            controller: widget.telController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Telephone'),
            validator: _validateTel,
          ),
          TextFormField(
            controller: widget.ageController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Age'),
            validator: _validateAge,
          ),
        ],
      ),
    );
  }
}
