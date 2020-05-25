import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:whatsapp/models/usuario.dart';
import 'package:whatsapp/widgets/raisedButtonWidget.dart';
import 'package:whatsapp/widgets/textFormFieldWidget.dart';

class Cadastro extends StatefulWidget {
  @override
  CadastroState createState() => CadastroState();
}

class CadastroState extends State<Cadastro> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String _mensagemErro = "";

  _cadastrarUsuario() {
    Usuario usuario = Usuario();
    usuario.nome = _controllerNome.text;
    usuario.email = _controllerEmail.text;
    usuario.senha = _controllerSenha.text;

    FirebaseAuth auth = FirebaseAuth.instance;
    auth
        .createUserWithEmailAndPassword(
      email: usuario.email,
      password: usuario.senha,
    )
        .then((firebaseUser) {
      Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
      _limpaControllers();
    }).catchError((onErro) {
      print('Erro' + onErro);
      setState(() {
        _mensagemErro = "Erro ao cadastrar" + onErro;
      });
    });
  }

  _limpaControllers() {
    _controllerEmail.clear();
    _controllerNome.clear();
    _controllerSenha.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Container(
        decoration: BoxDecoration(color: Color(0xff075E54)),
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Image.asset('assets/img/usuario.png',
                        width: 200, height: 150),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: TextFormFieldWidget(
                            autoFocus: true,
                            filled: true,
                            hintText: "Nome",
                            validator: (value) {
                              if (value.isEmpty) return 'Informe um nome';
                              return null;
                            },
                            controller: _controllerNome)
                        .textFieldCircle(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: TextFormFieldWidget(
                      hintText: "E-mail",
                      validator: (value) {
                        if (value.isEmpty) return 'Informe um e-mail';
                        return null;
                      },
                      controller: _controllerEmail,
                    ).textFieldCircle(),
                  ),
                  TextFormFieldWidget(
                    obscureText: true,
                    hintText: "Senha",
                    validator: (value) {
                      if (value.isEmpty) return 'Informe uma senha';
                      return null;
                    },
                    controller: _controllerSenha,
                  ).textFieldCircle(),
                  Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: RaisedButtonWidget(
                        name: "Cadastrar",
                        onPressed: () {
                          if (_formKey.currentState.validate())
                            _cadastrarUsuario();
                        },
                      ).raisedButtonCircle()),
                  Center(
                      child: Text(
                    _mensagemErro,
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
