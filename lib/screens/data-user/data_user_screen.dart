import 'package:ESPP_Rewards_App_Portador/blocs/data_user_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'data_user_input.dart';

class DataUserScreen extends StatelessWidget {
  final dataUserBloc = BlocProvider.getBloc<DataUserBloc>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                child: Column(
                  children: [
                    Icon(Icons.edit, size: 20),
                    Text('Dados Usuário', style: TextStyle(fontSize: 15)),
                  ],
                ),
              ),
              Tab(
                child: Column(
                  children: [
                    Icon(Icons.vpn_key, size: 20),
                    Text('Senha', style: TextStyle(fontSize: 15)),
                  ],
                ),
              ),
            ],
          ),
          title: Text('Alteração Dados de Cadastro'),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: FutureBuilder(
                future: dataUserBloc.getDataUser(),
                builder: (context, snapshot) {
                  print(snapshot.data);
                  if (snapshot.hasData) {
                    return Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.only(top: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          DataUserInput(label: 'E-mail', value: snapshot.data.email, typeInput: 'email'),
                          SizedBox(height: 20),
                          DataUserInput(label: 'Celular', value: snapshot.data.tel2, typeInput: 'fone'),
                          SizedBox(height: 20),
                          DataUserInput(label: 'Data de Nascimento', value: snapshot.data.birthDate, typeInput: 'birthDate'),
                          SizedBox(height: 20),
                          SizedBox(
                            height: 45,
                            child: RaisedButton(
                              color: Colors.indigo[900],
                              textColor: Colors.white,
                              onPressed: () => {},
                              child: Text('Alterar'),
                            ),
                          )
                        ],
                      ),
                    );
                  }

                  return Container(height: 300, child: Center(child: CircularProgressIndicator(backgroundColor: Colors.black)));
                },
              ),
            ),
            Icon(Icons.directions_transit),
          ],
        ),
      ),
    );
  }
}
