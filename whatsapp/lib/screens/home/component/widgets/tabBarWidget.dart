import 'package:flutter/material.dart';

class TabBarWidget {
  TabController controller;

  TabBarWidget({this.controller});

  Widget tabBarWidget() {
    return TabBar(
        indicatorWeight: 4,
        labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        controller: this.controller,
        indicatorColor: Colors.white,
        tabs: <Widget>[
          Tab(
            text: "Conversas",
          ),
          Tab(
            text: "Contatos",
          ),
        ]);
  }
}
