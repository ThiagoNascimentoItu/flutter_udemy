import 'package:flutter/material.dart';
import 'package:whatsapp/widgets/raisedButtonWidget.dart';

import 'package:whatsapp/widgets/textFieldWidget.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color(0xff075E54)),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                    'assets/img/logo.png',
                    width: 200,
                    height: 150,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextFieldWidget(
                          hintText: "E-mail",
                          textInputType: TextInputType.emailAddress)
                      .textFieldCircle(),
                ),
                TextFieldWidget(
                     hintText: "Senha")
                    .textFieldCircle(),
                Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 10),
                    child: RaisedButtonWidget(
                      onPressed: () {},
                      name: "Entrar",
                    ).raisedButtonCircle()),
                Center(
                  child: GestureDetector(
                    child: Text(
                      'Não tem conta? cadastre-se',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed('/cadastro');
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
