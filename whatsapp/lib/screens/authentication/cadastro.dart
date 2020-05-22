import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp/models/usuario.dart';
import 'package:whatsapp/widgets/raisedButtonWidget.dart';
import 'package:whatsapp/widgets/textFieldWidget.dart';

class Cadastro extends StatefulWidget {
  @override
  CadastroState createState() => CadastroState();
}

class CadastroState extends State<Cadastro> {
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String _mensagemErro = "";
  _validarCampos() {
    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if (nome.isNotEmpty) {
      if (email.isNotEmpty && email.contains("@")) {
        if (senha.isNotEmpty && senha.length > 6) {
          setState(() {
            _mensagemErro = "";
          });
          Usuario usuario = Usuario();
          usuario.nome = nome;
          usuario.email = email;
          usuario.senha = senha;

          _cadastrarUsuario(usuario);
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
    } else {
      setState(() {
        _mensagemErro = "Preencha o nome";
      });
    }
  }

  _cadastrarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;
    print('object' + usuario.email.toString());
    auth
        .createUserWithEmailAndPassword(
          email: usuario.email,
          password: usuario.senha,
        )
        .then((firebaseUser) => {
              Navigator.of(context).pushNamed("/home"),
            })
        .catchError((onErro) {
      print('Erro' + onErro);
      setState(() {
        _mensagemErro = "Erro ao cadastrar" + onErro;
      });
    });
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
                  child: TextFieldWidget(
                          autoFocus: true,
                          filled: true,
                          hintText: "Nome",
                          controller: _controllerNome)
                      .textFieldCircle(),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextFieldWidget(
                    hintText: "E-mail",
                    controller: _controllerEmail,
                  ).textFieldCircle(),
                ),
                TextFieldWidget(
                  obscureText: true,
                  hintText: "Senha",
                  controller: _controllerSenha,
                ).textFieldCircle(),
                Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: RaisedButtonWidget(
                      name: "Cadastrar",
                      onPressed: () {
                        _validarCampos();
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
    );
  }
}
