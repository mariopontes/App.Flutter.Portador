import 'package:ESPP_Rewards_App_Portador/blocs/card_actions_bloc.dart';
import 'package:ESPP_Rewards_App_Portador/blocs/list_card_block.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class BoxCard extends StatelessWidget {
  final _cardActionsBloc = BlocProvider.getBloc<CardActionsBloc>();
  final cardBloc = BlocProvider.getBloc<CardBloc>();

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

        return StreamBuilder(
          stream: cardBloc.actionState,
          builder: (context, snapshot) {
            return Container(
              child: Center(
                child: Material(
                  child: InkWell(
                    onTap: () {
                      if (snapshot.data != 'loading') {
                        if (cardOptions == 'extract') {
                          Navigator.pushNamed(context, '/extrato-cartao');
                        } else {
                          showDialog(
                            barrierDismissible: true, //tapping outside dialog will close the dialog if set 'true'
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('${cardOptions == 'block' ? 'Bloquear' : 'Desbloquear'}'),
                                content: Text('Deseja ${cardOptions == 'block' ? 'Bloquear' : 'Desbloquear'} seu cartão temporariamente'),
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

                                      Future.delayed(Duration(milliseconds: 200), () {
                                        Navigator.of(context).pop();
                                      });
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
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
                color: snapshot.data != 'loading' ? Theme.of(context).backgroundColor : Colors.indigo[500],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 0.5, color: snapshot.data != 'loading' ? Colors.black38 : Colors.grey),
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
      },
    );
  }
}
