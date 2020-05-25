import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/models/usuario.dart';
import 'package:whatsapp/widgets/raisedButtonWidget.dart';

import 'package:whatsapp/widgets/textFieldWidget.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String _mensagemErro = "";

  _validarCampos() {
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if (email.isNotEmpty && email.contains("@")) {
      if (senha.isNotEmpty && senha.length > 6) {
        setState(() {
          _mensagemErro = "";
        });
        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;

        _logarUsuario(usuario);
      } else {
        setState(() {
          _mensagemErro = "Preencha a senha";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Preencha o e-mail";
      });
    }
  }

  _logarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .signInWithEmailAndPassword(
      email: usuario.email,
      password: usuario.senha,
    )
        .then((firabeUser) {
      Navigator.of(context).pushNamed("/home");
    }).catchError((onError) {
      setState(() {
        _mensagemErro = "Erro ao autenticar";
      });
    });
  }

Future _verificaUsuarioLogado() async{
  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseUser usuarioLogado = await auth.currentUser();
  if (usuarioLogado != null) {
    Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
  }

}
  @override
  void initState() {
    _verificaUsuarioLogado();
    super.initState();
  }

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
                          controller: _controllerEmail,
                          textInputType: TextInputType.emailAddress)
                      .textFieldCircle(),
                ),
                TextFieldWidget(
                  hintText: "Senha",
                  obscureText: true,
                  controller: _controllerSenha,
                ).textFieldCircle(),
                Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 10),
                    child: RaisedButtonWidget(
                      onPressed: () {
                        _validarCampos();
                      },
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
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Center(
                    child: Text(
                      _mensagemErro,
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
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
