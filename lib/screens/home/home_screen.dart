import 'dart:async';

import 'package:ESPP_Rewards_App_Portador/widgets/custom_carousel.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../../blocs/authentication_block.dart';
import '../../screens/login/login_screen.dart';
import '../../widgets/container_box_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

dynamic decodedToken = {};

class _HomeScreenState extends State<HomeScreen> {
  final bloc = BlocProvider.getBloc<AuthenticationBloc>();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        actions: [
          PopupMenuButton<String>(
            onSelected: options,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'dadosCadastrais',
                child: Text('Alterar Dados Cadastrais'),
              ),
              const PopupMenuItem<String>(
                value: 'alterarSenha',
                child: Text('Alterar Senha'),
              ),
              const PopupMenuItem<String>(
                value: 'termosUso',
                child: Text('Termos de Uso'),
              ),
              const PopupMenuItem<String>(
                value: 'sair',
                child: Text('Sair'),
              ),
            ],
          )
        ],
        title: FutureBuilder(
          future: _getToken(),
          initialData: {},
          builder: (context, snapshot) {
            print(snapshot.data);
            if (snapshot.hasData) {
              return Text('Olá, ${snapshot.data['given_name']}', style: TextStyle(fontSize: 18));
            } else {
              return Text('Olá, Usuário');
            }
          },
        ),
      ),
      body: Container(
          color: Color.fromRGBO(108, 201, 229, 0.5),
          padding: EdgeInsets.only(top: 20),
          child: StreamBuilder(
            builder: (context, snapshot) {
              return ListView(
                children: [
                  CustomCarousel(),
                  ContainerCardBox(),
                ],
              );
            },
          )),
    );
  }

  Future _getToken() async {
    decodedToken = await bloc.getTokenDecoded();
    return decodedToken;
  }

  void options(String action) async {
    print(action);
    if (action == 'sair') {
      bloc.signOut();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
    }
    if (action == 'termosUso') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // retorna um objeto do tipo Dialog
          return AlertDialog(
            title: new Text("Alert Dialog titulo"),
            content: new Text("Alert Dialog body"),
            actions: <Widget>[
              // define os botões na base do dialogo
              new FlatButton(
                child: new Text("Fechar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
