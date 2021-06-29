import 'package:flutter/material.dart';
import 'package:untitled2/components/text_field_container.dart';
import 'package:untitled2/constants/constant.dart';

class RoundedPasswordField extends StatelessWidget {
  final String hintText;
  final Icon iconShape;
  final ValueChanged<String> onChanged;
  final Function validator;
  final TextEditingController controller;

  const RoundedPasswordField({
    Key key,
    this.hintText,
    this.onChanged,
    this.iconShape,
    this.validator,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        validator: validator,
        controller: controller,
        obscureText: true,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 15.0, color: Colors.black45),
          icon: iconShape,
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
