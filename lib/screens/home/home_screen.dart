import 'dart:async';
import 'package:ESPP_Rewards_App_Portador/blocs/authentication_block.dart';
import 'package:ESPP_Rewards_App_Portador/screens/login/login_screen.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
      body: CarouselSlider(
        options: CarouselOptions(
          height: 225,
          viewportFraction: 0.9,
          initialPage: 0,
          enableInfiniteScroll: false,
          reverse: false,
          autoPlay: false,
        ),
        items: [1, 2, 3, 4, 5].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Status: Cartão bloqueado'),
                          Text('Logo.PNG'),
                        ],
                      ),
                    ),
                    Text('Saldo : R\$ 100.00', style: TextStyle(fontSize: 16)),
                    Text('**** **** **** 0000', style: TextStyle(fontSize: 26)),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Vencimento: 10/29'),
                              Text('CVV: 123'),
                            ],
                          ),
                          Text('Logo.PNG'),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Future _getToken() async {
    decodedToken = await bloc.getTokenDecoded();
    return decodedToken;
  }

  void options(String value) async {
    print(value);
    if (value == 'sair') {
      bloc.signOut();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }
}
