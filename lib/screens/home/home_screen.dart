import 'package:ESPP_Rewards_App_Portador/widgets/custom_carousel.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../../screens/data-user/data_user_screen.dart';
import '../../screens/terms/terms_screen.dart';
import '../../blocs/home_bloc.dart';
import '../../blocs/authentication_block.dart';
import '../../widgets/container_box_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeBloc = BlocProvider.getBloc<HomeBloc>();
  final _authBloc = BlocProvider.getBloc<AuthenticationBloc>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String titleHeader = 'Olá, Usuário';

  @override
  void initState() {
    super.initState();
    _getToken();

    _homeBloc.outState.listen((state) {
      Future.delayed(Duration(seconds: 0), () {
        if (state == BlockState.TermosOfUse) Navigator.push(context, MaterialPageRoute(builder: (context) => TermsScreen()));
        if (state == BlockState.ChangeUserData) Navigator.push(context, MaterialPageRoute(builder: (context) => DataUserScreen()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
            onSelected: options,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'ChangeUserData',
                child: Text('Alterar Dados Cadastrais'),
              ),
              const PopupMenuItem<String>(
                value: 'ChangePassword',
                child: Text('Alterar Senha'),
              ),
              const PopupMenuItem<String>(
                value: 'TermosOfUse',
                child: Text('Termos de Uso'),
              ),
              const PopupMenuItem<String>(
                value: 'sair',
                child: Text('Sair'),
              ),
            ],
          )
        ],
        title: Text(titleHeader),
      ),
      body: Container(
          color: Color.fromRGBO(108, 201, 229, 0.5),
          padding: EdgeInsets.only(top: 20),
          child: RefreshIndicator(
            child: ListView(
              children: [
                CustomCarousel(),
                ContainerCardBox(),
              ],
            ),
            onRefresh: _refreshLocalGallery,
          )),
    );
  }

  Future _getToken() async {
    var decodedToken = await _authBloc.getTokenDecoded();
    ////////////////////////     PRECISA SER REFATORADO     //////////////////////////
    setState(() {
      if (decodedToken != null) {
        titleHeader = '${decodedToken['given_name']}';
      }
    });
  }

  Future<Null> _refreshLocalGallery() async {
    print('refreshing stocks...');
  }

  void options(String action) async {
    print('options $action');
    _homeBloc.setScreen(action);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
