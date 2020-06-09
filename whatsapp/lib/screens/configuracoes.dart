import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp/widgets/raisedButtonWidget.dart';
import 'package:whatsapp/widgets/textFormFieldWidget.dart';

class Configuracoes extends StatefulWidget {
  @override
  _ConfiguracoesState createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controllerNome = TextEditingController();
  File _imagem;
  String _idUsuarioLogado;
  bool _subindoImagem = false;
  String _urlImagemRecuperada;

  Future _recuperarImagem(String origemImagem) async {
    File imagemSelecionada;
    switch (origemImagem) {
      case "camera":
        imagemSelecionada =
            await ImagePicker.pickImage(source: ImageSource.camera);
        break;
      case "galeria":
        imagemSelecionada =
            await ImagePicker.pickImage(source: ImageSource.gallery);
        break;
      default:
    }
    setState(() {
      _imagem = imagemSelecionada;
      if (_imagem != null) {
        _subindoImagem = true;
        _uploadImage();
      }
    });
  }

  _recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    _idUsuarioLogado = usuarioLogado.uid;

    Firestore db = Firestore.instance;
    DocumentSnapshot snapshot =
        await db.collection("usuario").document(_idUsuarioLogado).get();
    Map<String, dynamic> dados = snapshot.data;
    _controllerNome.text = dados["nome"];
    if (dados["urlImagem"] != null) {
      _urlImagemRecuperada = dados["urlImagem"];
    }
  }

  Future _recuperarUrlImagem(StorageTaskSnapshot snapshot) async {
    String url = await snapshot.ref.getDownloadURL();
    _atualizarUrlImagemFirestore(url);
    setState(() {
      _urlImagemRecuperada = url;
    });
  }

  _atualizarUrlImagemFirestore(String url) {
    Firestore db = Firestore.instance;
    Map<String, dynamic> dadosAtualizar = {
      "urlImagem": url,
    };

    db
        .collection("usuario")
        .document(_idUsuarioLogado)
        .updateData(dadosAtualizar);
  }

  _atualizarNomeFirestore() {
    String nome = _controllerNome.text;
    Firestore db = Firestore.instance;
    Map<String, dynamic> dadosAtualizar = {
      "nome": nome,
    };

    db
        .collection("usuario")
        .document(_idUsuarioLogado)
        .updateData(dadosAtualizar);
  }

  Future _uploadImage() async {
    FirebaseStorage storege = FirebaseStorage.instance;
    StorageReference pastaRaiz = storege.ref();
    StorageReference arquivo =
        pastaRaiz.child("perfil").child(_idUsuarioLogado + ".jpg");

    StorageUploadTask task = arquivo.putFile(_imagem);
    task.events.listen((event) {
      if (event.type == StorageTaskEventType.progress) {
        setState(() {
          _subindoImagem = true;
        });
      } else if (event.type == StorageTaskEventType.success) {
        setState(() {
          _subindoImagem = false;
        });
        task.onComplete.then((StorageTaskSnapshot snapshot) {
          _recuperarUrlImagem(snapshot);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _recuperarDadosUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
            child: SingleChildScrollView(
                child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              child: _subindoImagem ? CircularProgressIndicator() : Container(),
            ),
            CircleAvatar(
              radius: 100,
              backgroundColor: Colors.grey,
              backgroundImage: _urlImagemRecuperada != null
                  ? NetworkImage(_urlImagemRecuperada)
                  : null,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    _recuperarImagem("camera");
                  },
                  child: Text('Câmera'),
                ),
                FlatButton(
                  onPressed: () {
                    _recuperarImagem("galeria");
                  },
                  child: Text('Galeria'),
                ),
              ],
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: TextFormFieldWidget(
                  hintText: "Nome",
                  validator: (value) {
                    if (value.isEmpty) return 'Informe um Nome';
                    return null;
                  },
                  controller: _controllerNome,
                ).textFieldCircle(),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 15, bottom: 10),
                child: RaisedButtonWidget(
                  name: "Salvar",
                  onPressed: () {
                    if (_formKey.currentState.validate())
                      return _atualizarNomeFirestore();
                  },
                ).raisedButtonCircle()),
          ],
        ))),
      ),
    );
  }
}
