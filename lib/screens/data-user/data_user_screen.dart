import 'package:flutter/material.dart';

class DataUserScreen extends StatelessWidget {
  const DataUserScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Alteração de Dados Cadastrais')),
      body: Container(
        color: Colors.amberAccent,
      ),
    );
  }
}
