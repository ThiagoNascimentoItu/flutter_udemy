import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/screens/home/component/widgets/tabBarViewWidget.dart';
import 'package:whatsapp/screens/home/component/widgets/tabBarWidget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> _itensMenu = ["Configuração", "Deslogar"];
  // Future _recuperaUsuarioLogado() async {
  // FirebaseAuth auth = FirebaseAuth.instance;
  // FirebaseUser _usuarioLogado = await auth.currentUser();
  // }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  _escolhaMenuItem(String itemEscolhido) {
    switch (itemEscolhido) {
      case "Configuração":
        Navigator.of(context).pushNamed('/configuracoes');
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
        bottom: TabBarWidget(controller: _tabController).tabBarWidget(),
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
      body: TabBarViewWidget(controller: _tabController).tabBarView(),
    );
  }
}
