import 'package:ESPP_Rewards_App_Portador/blocs/card_actions_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class BoxCard extends StatelessWidget {
  final _cardActionsBloc = BlocProvider.getBloc<CardActionsBloc>();

  final String title;
  final String cardOptions;

  BoxCard({
    @required this.title,
    @required this.cardOptions,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        _cardActionsBloc.outState.listen(
          (state) {
            if (state == AuthState.Fail) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: StreamBuilder(
                    stream: _cardActionsBloc.stateError,
                    initialData: 'Falha na operação',
                    builder: (context, snapshot) {
                      return Text(snapshot.data);
                    },
                  ),
                ), // SnackBar
              );
            }
          },
        );

        return Container(
          child: Center(
            child: new Material(
              child: new InkWell(
                onTap: () {
                  showDialog(
                      barrierDismissible: true, //tapping outside dialog will close the dialog if set 'true'
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('${cardOptions == 'block' ? 'Bloquear' : 'Desbloquear'}'),
                          content: Text('Deseja ${cardOptions == 'block' ? 'Bloquear' : 'Besbloquear'} seu cartão temporariamente'),
                          actions: [
                            FlatButton(
                              child: Text("Cancelar"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text('${cardOptions == 'block' ? 'Bloquear' : 'Desbloquear'}'),
                              onPressed: () {
                                if (cardOptions == 'block') {
                                  _cardActionsBloc.blockCard();
                                }
                                if (cardOptions == 'desblock') {
                                  _cardActionsBloc.unBlockCard();
                                }
                                if (cardOptions == 'extract') print('Redirect To Extrat Card');

                                Future.delayed(Duration(milliseconds: 200), () {
                                  Navigator.of(context).pop();
                                });
                              },
                            ),
                          ],
                        );
                      });
                },
                child: Center(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              color: Colors.transparent,
            ),
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: Colors.black38),
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
        );
      },
    );
  }
}
