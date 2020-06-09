import 'package:flutter/material.dart';
import 'package:whatsapp/models/conversar.dart';

class Conversas extends StatefulWidget {
  @override
  _ConversasState createState() => _ConversasState();
}

class _ConversasState extends State<Conversas> {
  List<Conversa> listaConversas = [
    Conversa(
      "Ana",
      "Olá tudo bem",
      "https://firebasestorage.googleapis.com/v0/b/whatflutter.appspot.com/o/perfil%2Fperfil1.jpg?alt=media&token=2a23325d-4c5c-4238-a157-f91c2928f36b",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listaConversas.length,
        itemBuilder: (context, index) {
          Conversa conversa = listaConversas[index];
          return ListTile(
            contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            leading: CircleAvatar(
              maxRadius: 30,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(conversa.caminhoFoto),
            ),
            title: Text(
              conversa.nome,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text(
              conversa.mensagem,
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          );
        });
  }
}
