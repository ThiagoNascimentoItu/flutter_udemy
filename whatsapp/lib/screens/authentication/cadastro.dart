import 'package:flutter/material.dart';
import 'package:whatsapp/widgets/raisedButtonWidget.dart';
import 'package:whatsapp/widgets/textFieldWidget.dart';

class Cadastro extends StatefulWidget {
  @override
  CadastroState createState() => CadastroState();
}

class CadastroState extends State<Cadastro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Container(
        decoration: BoxDecoration(color: Color(0xff075E54)),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Image.asset(
                    'assets/img/usuario.png',
                    width: 200,
                    height: 150,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextFieldWidget(
                    autoFocus: true,
                    filled: true,
                    hintText: "Nome",
                  ).textFieldCircle(),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextFieldWidget(hintText: "E-mail").textFieldCircle(),
                ),
                TextFieldWidget(hintText: "Senha").textFieldCircle(),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: RaisedButtonWidget(
                    name: "Cadastrar",
                    onPressed: () {},
                  ).raisedButtonCircle(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
