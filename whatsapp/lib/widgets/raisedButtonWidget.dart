import 'package:flutter/material.dart';

class RaisedButtonWidget {
  VoidCallback onPressed;
  String name;
  Color colors;

  RaisedButtonWidget({
    @required this.onPressed,
    @required this.name,
    this.colors = Colors.green,
  });

  Widget raisedButtonCircle() {
    return RaisedButton(
      child: Text(
        this.name,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      color: this.colors,
      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      onPressed: this.onPressed,
    );
  }
}
