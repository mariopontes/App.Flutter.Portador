import 'package:ESPP_Rewards_App_Portador/blocs/card_extract_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class ExtractScreen extends StatelessWidget {
  final _cardExtractBloc = BlocProvider.getBloc<CardExtractBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Extratos do Cartão')),
      body: Container(
        color: Color.fromRGBO(108, 201, 229, 0.5),
        padding: EdgeInsets.only(top: 0, left: 20, right: 20),
        child: RefreshIndicator(
          onRefresh: () => _screenRefresh(),
          child: FutureBuilder(
            future: _cardExtractBloc.getCardExtract(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('5 dias'),
                        Text('15 dias'),
                        Text('30 dias'),
                        Text('60 dias'),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.separated(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(snapshot.data[index].timestamp + ' as ' + snapshot.data[index].hourSec),
                                  Text(snapshot.data[index].tipoTransacao),
                                  Text(snapshot.data[index].statusTransacao, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Text('R\$${snapshot.data[index].valorInterno}', style: TextStyle(fontSize: 16))
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                      ),
                    ),
                  ],
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }

  Future _screenRefresh() async {
    print('Refresh Screen');
  }
}
