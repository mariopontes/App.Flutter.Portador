import 'package:ESPP_Rewards_App_Portador/blocs/authentication_block.dart';
import 'package:ESPP_Rewards_App_Portador/blocs/home_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

final authBloc = BlocProvider.getBloc<AuthenticationBloc>();
final homeBloc = BlocProvider.getBloc<HomeBloc>();

void options(String action) async {
  homeBloc.setScreen(action);

  if (action == 'sair') {
    authBloc.signOut();
    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}

class CustomAppBard {
  static getAppBar({@required String title}) {
    return AppBar(
      // backgroundColor: Theme.of(context).backgroundColor,
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
      title: Text(title),
    );
  }
}
