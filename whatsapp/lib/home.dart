import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:whatsapp/screens/abaContatos.dart';
import 'package:whatsapp/screens/abaConversas.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> _itensMenu = ["Configuração", "Deslogar"];
  String _emailUsuario = "";
  Future _recuperaUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();

    setState(() {
      _emailUsuario = usuarioLogado.email;
    });
  }

  @override
  void initState() {
    super.initState();
    _recuperaUsuarioLogado();
    _tabController = TabController(length: 2, vsync: this);
  }

  _escolhaMenuItem(String itemEscolhido) {
    switch (itemEscolhido) {
      case "Configuração":
        break;
      case "Deslogar":
      _deslogarUsuario();
        break;
      default:
    }
  }

  _deslogarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();

    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WhatsApp'),
        bottom: TabBar(
            indicatorWeight: 4,
            labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            controller: _tabController,
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(
                text: "Conversas",
              ),
              Tab(
                text: "Contatos",
              ),
            ]),
        actions: <Widget>[
          PopupMenuButton<String>(
              onSelected: _escolhaMenuItem,
              itemBuilder: (context) {
                return _itensMenu.map((String item) {
                  return PopupMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList();
              })
        ],
      ),
      body: TabBarView(controller: _tabController, children: <Widget>[
        AbaConversas(),
        AbaContatos(),
      ]),
    );
  }
}
