import 'package:flutter/material.dart';
import 'package:whatsapp/models/usuario.dart';

class Mensagens extends StatefulWidget {
  Usuario contato;

  Mensagens({this.contato});
  @override
  _MensagensState createState() => _MensagensState();
}

class _MensagensState extends State<Mensagens> {
  TextEditingController _controllerMensagem = TextEditingController();
  _enviarFoto() {}
  _enviarMensagem() {}
  @override
  Widget build(BuildContext context) {
    var caixaMensagem = Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
                padding: EdgeInsets.only(right: 8),
                child: TextField(
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  controller: _controllerMensagem,
                  obscureText: false,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 8, 32, 8),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Digite uma mensagem",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      prefixIcon: IconButton(
                          icon: Icon(Icons.camera_alt),
                          onPressed: () {
                            _enviarFoto();
                          })),
                )),
          ),
          FloatingActionButton(
              backgroundColor: Color(0xff075E54),
              child: Icon(Icons.send, color: Colors.white),
              mini: true,
              onPressed: _enviarMensagem())
        ],
      ),
    );

    var listView = Expanded(
        child: ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {},
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contato.nome),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("img/bg.png"), fit: BoxFit.cover)),
        child: SafeArea(
          child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: <Widget>[Text("ListView"), caixaMensagem],
              )),
        ),
      ),
    );
  }
}
