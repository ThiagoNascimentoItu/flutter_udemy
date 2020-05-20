import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

void _teste(){
  Firestore.instance
      .collection("usuarios")
      .document("001")
      .setData({"nome": "Thiago"});
}

class _HomeState extends State<Home> {
 
  @override
  Widget build(BuildContext context) {
    _teste();
    return Scaffold(
        body: Center(
      child: Text('data'),
    ));
  }
}
