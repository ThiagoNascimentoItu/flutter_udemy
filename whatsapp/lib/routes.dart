import 'package:flutter/material.dart';

import 'package:whatsapp/screens/authentication/cadastro.dart';
import 'package:whatsapp/screens/authentication/login.dart';

final Map<String, WidgetBuilder> routesWidget = <String, WidgetBuilder>{
  "/login": (BuildContext context) => Login(),
  "/cadastro":(BuildContext context) => Cadastro()
};