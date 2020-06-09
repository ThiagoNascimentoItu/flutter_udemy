import 'package:flutter/material.dart';

import 'package:whatsapp/screens/authentication/cadastro.dart';
import 'package:whatsapp/screens/authentication/login.dart';
import 'package:whatsapp/screens/configuracoes.dart';
import 'package:whatsapp/screens/mensagens.dart';
import 'screens/home/home.dart';

final Map<String, WidgetBuilder> routesWidget = <String, WidgetBuilder>{
  
  "/home": (BuildContext context) => Home(),
  "/login": (BuildContext context) => Login(),
  "/cadastro": (BuildContext context) => Cadastro(),
  "/configuracoes": (BuildContext context) => Configuracoes(),
  "/mensagens": (BuildContext context) => Mensagens()
};
