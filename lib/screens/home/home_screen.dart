import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../../blocs/home_bloc.dart';
import '../../blocs/authentication_block.dart';
import './container_box_card.dart';
import './custom_carousel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeBloc = BlocProvider.getBloc<HomeBloc>();
  final _authBloc = BlocProvider.getBloc<AuthenticationBloc>();

  StreamSubscription streamSubscription;

  @override
  initState() {
    super.initState();
    getToken();

    streamSubscription = _homeBloc.outState.listen(
      (state) {
        if (state == BlockState.TermosOfUse) Navigator.pushNamed(context, '/termos-uso');
        if (state == BlockState.ChangeUserData) Navigator.pushNamed(context, '/alterações-dados');

        if (state == BlockState.SignOut) {
          print('Aqui');
          _authBloc.signOut();
          Navigator.pop(context);
          Navigator.pushNamed(context, '/login');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
            onSelected: options,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(value: 'ChangeUserData', child: Text('Alterar Dados Cadastrais')),
              PopupMenuItem<String>(value: 'ChangePassword', child: Text('Alterar Senha')),
              PopupMenuItem<String>(value: 'TermosOfUse', child: Text('Termos de Uso')),
              PopupMenuItem<String>(value: 'Sair', child: Text('Sair')),
            ],
          )
        ],
        title: StreamBuilder(
          initialData: 'Usuário',
          stream: _homeBloc.nameUser,
          builder: (context, snapshot) {
            return Text('Olá, ${snapshot.data}');
          },
        ),
      ),
      body: Container(
        color: Color.fromRGBO(108, 201, 229, 0.5),
        padding: EdgeInsets.only(top: 20),
        child: RefreshIndicator(
          onRefresh: () => _refreshLocalGallery(),
          child: ListView(
            children: [
              CustomCarousel(),
              ContainerCardBox(),
            ],
          ),
        ),
      ),
    );
  }

  Future getToken() async {
    var decodedToken = await _authBloc.getTokenDecoded();

    if (decodedToken != null) {
      _homeBloc.setNameUser(decodedToken['given_name']);
    }
  }

  Future _refreshLocalGallery() async {
    setState(() {});
  }

  void options(String action) async {
    print('options $action');
    _homeBloc.setScreen(action);
  }

  @override
  void dispose() {
    super.dispose();
    streamSubscription.cancel();
  }
}
