import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _listaTarefa = [];
  Map<String, dynamic> _ultimaTarefaRemovida = Map();
  TextEditingController _controllerTarefa = TextEditingController();

  Future<File> _getFile() async {
    final diretorio = await getApplicationDocumentsDirectory();
    return File("${diretorio.path}/dados.json");
  }

  _salvarTarefa() {
    String textoDigitado = _controllerTarefa.text;
    Map<String, dynamic> tarefa = Map();
    tarefa["titulo"] = textoDigitado;
    tarefa["realizada"] = false;

    setState(() {
      _listaTarefa.add(tarefa);
    });
    _salvarArquivo();
    _controllerTarefa.text = "";
  }

  _salvarArquivo() async {
    var arquivo = await _getFile();
    String dados = jsonEncode(_listaTarefa);
    arquivo.writeAsString(dados);
  }

  _lerArquivo() async {
    try {
      final arquivo = await _getFile();
      return arquivo.readAsString();
    } catch (e) {
      return null;
    }
  }

  Widget criarItemLista(context, index) {
    final item = _listaTarefa[index]["titulo"];

    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        //Recupera o ultimo item removido
        _ultimaTarefaRemovida = _listaTarefa[index];
        //Remove lista de tarefa
        _listaTarefa.removeAt(index);
        _salvarArquivo();

        //snackbar
        final snackbar = SnackBar(
          duration: Duration(seconds: 5),
          content: Text('Removeu'),
          action: SnackBarAction(
            label: "Desfazer",
            onPressed: () {
              setState(() {
                _listaTarefa.insert(index, _ultimaTarefaRemovida);
              });
              _salvarArquivo();
            },
          ),
        );
        Scaffold.of(context).showSnackBar(snackbar);
      },
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            )
          ],
        ),
      ),
      child: CheckboxListTile(
        title: Text(_listaTarefa[index]['titulo']),
        value: _listaTarefa[index]['realizada'],
        onChanged: (valorAlterado) {
          setState(() {
            _listaTarefa[index]['realizada'] = valorAlterado;
          });
          _salvarArquivo();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _lerArquivo().then((dados) {
      setState(() {
        _listaTarefa = jsonDecode(dados);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista tarefa'),
        backgroundColor: Colors.purple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Adicionar tarefa'),
                  content: TextField(
                    controller: _controllerTarefa,
                    decoration: InputDecoration(
                      labelText: 'Digite sua tarefa',
                    ),
                    onChanged: (text) {},
                  ),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancelar',
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        _salvarTarefa();
                        Navigator.pop(context);
                      },
                      child: Text('Salvar'),
                    )
                  ],
                );
              });
        },
      ),
      body: Column(children: <Widget>[
        Expanded(
            child: ListView.builder(
                itemCount: _listaTarefa.length, itemBuilder: criarItemLista)),
      ]),
    );
  }
}
