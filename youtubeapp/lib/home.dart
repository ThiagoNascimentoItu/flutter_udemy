import 'package:flutter/material.dart';
import 'package:youtubeapp/customSeachDelegate.dart';
import 'package:youtubeapp/telas/inicio.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _indicetAtua = 0;
  String _resultado = "";

  @override
  Widget build(BuildContext context) {
    List<Widget> telas = [
      Inicio(_resultado),
      Inicio(_resultado),
      Inicio(_resultado),
      Inicio(_resultado),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.grey,
          opacity: 1,
        ),
        title: Image.asset(
          'assets/img/youtube.png',
          width: 98,
          height: 22,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String res = await showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
              setState(() {
                _resultado = res;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: telas[_indicetAtua],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        currentIndex: _indicetAtua,
        onTap: (indice) {
          setState(() {
            _indicetAtua = indice;
          });
        },
        items: [
          BottomNavigationBarItem(
            title: Text('Inicio'),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text('Em alta'),
            icon: Icon(Icons.whatshot),
          ),
          BottomNavigationBarItem(
            title: Text('Inscrições'),
            icon: Icon(Icons.subscriptions),
          ),
          BottomNavigationBarItem(
            title: Text('Biblioteca'),
            icon: Icon(Icons.folder),
          ),
        ],
      ),
    );
  }
}
