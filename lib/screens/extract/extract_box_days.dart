import 'package:ESPP_Rewards_App_Portador/blocs/card_extract_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class ExtractBoxDate extends StatelessWidget {
  final cardExtractBloc = BlocProvider.getBloc<CardExtractBloc>();

  final String title;
  final int days;

  ExtractBoxDate({
    @required this.title,
    @required this.days,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.symmetric(vertical: 12),
      onPressed: () => cardExtractBloc.getCardExtract(days: days),
      textColor: Colors.white,
      color: cardExtractBloc.numberPage == days ? Colors.white : Colors.indigo[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
        side: BorderSide(color: Colors.indigo[900]),
      ),
      child: Text(title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: cardExtractBloc.numberPage == days ? Colors.indigo[900] : Colors.white,
          )),
    );
  }
}
