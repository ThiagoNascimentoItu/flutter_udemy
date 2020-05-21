import 'package:flutter/material.dart';

class TextFieldWidget {
  bool autoFocus;
  String hintText;
  Color colors;
  bool filled;
  TextInputType textInputType;
  TextEditingController textEditingController;
  VoidCallback onTap;

  TextFieldWidget({
    // @required this.textEditingController,
    this.autoFocus = false,
    this.hintText = "",
    this.colors = Colors.white,
    this.filled = true,
    this.textInputType = TextInputType.text,   
    this.onTap 
  });

  Widget textFieldCircle() {
    return TextField(
      autofocus: this.autoFocus,
      keyboardType: this.textInputType,
      // controller: this.textEditingController,
      onTap: this.onTap,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
          filled: this.filled,
          fillColor: this.colors,
          hintText: this.hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
          )),
    );
  }
}
