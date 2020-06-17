import 'package:flutter/material.dart';
// import 'Login.dart';
import 'RouteGenerator.dart';
import 'dart:io';

import 'facebookAuth/authFacebook.dart';
import 'googleAuth/authGoogle.dart';

final ThemeData temaIOS =
    ThemeData(primaryColor: Colors.grey[200], accentColor: Color(0xff25D366));

final ThemeData temaPadrao = ThemeData(
  primaryColor: Color(0xff075E54),
  accentColor: Color(0xff25D366),
);

void main() {
  runApp(MaterialApp(
    // home: Login(),
    // home: AuthGoogle(),
    home: AuthFacebook(),
    theme: Platform.isIOS ? temaIOS : temaPadrao,
    initialRoute: "/",
    onGenerateRoute: RouteGenerator.generateRoute,
    debugShowCheckedModeBanner: false,
  ));
}
