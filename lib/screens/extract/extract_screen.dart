import 'package:ESPP_Rewards_App_Portador/blocs/card_extract_bloc.dart';
import 'package:ESPP_Rewards_App_Portador/models/card_extract_model.dart';
import 'package:ESPP_Rewards_App_Portador/screens/extract/extract_box_days.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ExtractScreen extends StatefulWidget {
  @override
  _ExtractScreenState createState() => _ExtractScreenState();
}

class _ExtractScreenState extends State<ExtractScreen> {
  final cardExtractBloc = BlocProvider.getBloc<CardExtractBloc>();
  final maskDate = MaskTextInputFormatter(mask: "##/##/####", filter: {"#": RegExp(r'[0-9]')});

  final _dataDe = TextEditingController();
  final _dataAte = TextEditingController();

  @override
  initState() {
    super.initState();

    cardExtractBloc.getCardExtract();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Extratos')),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              StreamBuilder(
                stream: cardExtractBloc.outState,
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ExtractBoxDate(title: '15 dias', days: 15),
                          ExtractBoxDate(title: '30 dias', days: 30),
                          ExtractBoxDate(title: '60 dias', days: 60),
                          ExtractBoxDate(title: '90 dias', days: 90),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 25),
                        child: ExpandablePanel(
                          header: Text('Demais períodos', style: TextStyle(fontSize: 20)),
                          expanded: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 15),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.info_rounded,
                                        color: Colors.amberAccent,
                                        size: 30,
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        'Nessa opção, selecione uma data inicial e uma data final para realizar a consulta. Em seguida, clique em buscar',
                                        softWrap: true,
                                        maxLines: 3,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Container(
                                      margin: EdgeInsets.only(right: 20),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            child: Text('De'),
                                          ),
                                          Container(
                                            height: 40,
                                            child: TextFormField(
                                              controller: _dataDe,
                                              keyboardType: TextInputType.number,
                                              inputFormatters: [maskDate],
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                                hintText: 'dd/mm/aaaa',
                                                labelStyle: TextStyle(
                                                  fontSize: 22,
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      margin: EdgeInsets.only(left: 20),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            child: Text('Até'),
                                          ),
                                          Container(
                                            height: 40,
                                            child: TextFormField(
                                              controller: _dataAte,
                                              keyboardType: TextInputType.number,
                                              inputFormatters: [maskDate],
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                                hintText: 'dd/mm/aaaa',
                                                labelStyle: TextStyle(
                                                  fontSize: 22,
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 15),
                                child: FlatButton(
                                  child: Text('Buscar'),
                                  color: Colors.purpleAccent,
                                  textColor: Colors.white,
                                  onPressed: () => cardExtractBloc.getCardExtract(dataDe: _dataDe.text, dataAte: _dataAte.text),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(thickness: 1),
                    ],
                  );
                },
              ),
              StreamBuilder(
                stream: cardExtractBloc.outState,
                initialData: 'loading',
                builder: (context, snapshot) {
                  if (snapshot.data == 'loading') {
                    return Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Center(child: CircularProgressIndicator(backgroundColor: Colors.black)),
                    );
                  }

                  if (snapshot.data == 'error') {
                    return Center(child: Text('falha na busca dos dados'));
                  }

                  if (snapshot.data.length == 0) {
                    return SizedBox(height: 50, child: Center(child: Text('Você não possui extratos', style: TextStyle(fontSize: 16))));
                  }

                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 15, bottom: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Movimentações',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.indigo[900],
                          ),
                          softWrap: true,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        color: Colors.grey[300],
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                        margin: EdgeInsets.only(bottom: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Histórico', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                            Text('Valor(R\$)', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      for (CardExtractModel e in snapshot.data)
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(e.timestamp + ' as ' + e.hourSec),
                                    Text(e.tipoTransacao),
                                    Text(e.statusTransacao, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Text('R\$ ${e.valorInterno}', style: TextStyle(fontSize: 16)),
                              ],
                            ),
                            Divider(),
                          ],
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
