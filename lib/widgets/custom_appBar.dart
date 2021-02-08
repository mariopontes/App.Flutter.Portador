import 'package:ESPP_Rewards_App_Portador/blocs/home_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final title;
  CustomAppBar({@required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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

  final homeBloc = BlocProvider.getBloc<HomeBloc>();

  void options(String action) async {
    homeBloc.setScreen(action);
  }
}
