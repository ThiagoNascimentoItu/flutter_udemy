import 'package:flutter/material.dart';

class TextFormFieldWidget {
  bool autoFocus;
  String hintText;
  Color fillColor;
  bool filled;
  TextInputType textInputType;
  TextEditingController controller;
  VoidCallback onTap;
  bool obscureText;
  FormFieldValidator<String> validator;

  TextFormFieldWidget({
    this.controller,
    this.autoFocus = false,
    @required  this.hintText,
    this.fillColor = Colors.white,
    this.filled = true,
    this.textInputType = TextInputType.text,   
    this.onTap,
    this.obscureText = false,
    this.validator
  });

  Widget textFieldCircle() {
    return TextFormField(
      autofocus: this.autoFocus,
      validator: this.validator,
      keyboardType: this.textInputType,
      controller: this.controller,
      obscureText: this.obscureText,
      onTap: this.onTap,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
          filled: this.filled,
          fillColor: this.fillColor,
          hintText: this.hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
          )),
    );
  }
}
