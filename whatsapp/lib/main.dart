import 'package:flutter/material.dart';
import 'package:whatsapp/routes.dart';
import 'package:whatsapp/screens/authentication/login.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Login(),
    initialRoute: '/',
    routes: routesWidget,
    theme: ThemeData(
      primaryColor: Color(0xff075E54),
      accentColor: Color(0xff25D366),
    ),
  ));
}
