import 'package:flutter/material.dart';
import 'package:whatsapp/screens/home/component/tabBar/contatos.dart';
import 'package:whatsapp/screens/home/component/tabBar/conversas.dart';

class TabBarViewWidget {
  TabController controller;

  TabBarViewWidget({this.controller});

  Widget tabBarView() {
    return TabBarView(controller: this.controller, children: <Widget>[
      Conversas(),
      Contatos(),
    ]);
  }
}
