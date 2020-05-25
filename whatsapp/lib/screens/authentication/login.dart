import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp/models/usuario.dart';

import 'package:whatsapp/widgets/raisedButtonWidget.dart';
import 'package:whatsapp/widgets/textFormFieldWidget.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String _mensagemErro = '';

  _autenticarUsuario() {
    Usuario usuario = Usuario();
    usuario.email = _controllerEmail.text;
    usuario.senha = _controllerSenha.text;

    FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .signInWithEmailAndPassword(
      email: usuario.email,
      password: usuario.senha,
    )
        .then((firebaseUser) {
      Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
      _limpaControllers();
    }).catchError((onError) {
      setState(() {
        _mensagemErro = "Erro ao autenticar";
      });
    });
  }

  Future _verificaUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    FirebaseUser usuarioLogado = await auth.currentUser();
    if (usuarioLogado != null) {
      Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
    }
  }

  _limpaControllers() {
    _controllerEmail.clear();
    _controllerSenha.clear();
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
        child: Form(
          key: _formKey,
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
                    child: TextFormFieldWidget(
                            hintText: "E-mail",
                            controller: _controllerEmail,
                            validator: (value) {
                              print('Email ' + value);
                              if (value.isEmpty) {
                                return 'Informe um e-mail valido';
                              }
                              return null;
                            },
                            textInputType: TextInputType.emailAddress)
                        .textFieldCircle(),
                  ),
                  TextFormFieldWidget(
                    hintText: "Senha",
                    obscureText: true,
                    controller: _controllerSenha,
                    validator: (value) {
                      if (value.isEmpty) return "Informe a senha para entrar ";
                      return null;
                    },
                  ).textFieldCircle(),
                  Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 10),
                      child: RaisedButtonWidget(
                        onPressed: () {
                          if (_formKey.currentState.validate())
                            _autenticarUsuario();
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
      ),
    );
  }
}
