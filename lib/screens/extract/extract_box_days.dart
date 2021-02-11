import 'package:ESPP_Rewards_App_Portador/blocs/card_extract_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExtractBoxDate extends StatelessWidget {
  final _cardExtractBloc = BlocProvider.getBloc<CardExtractBloc>();

  final String title;
  final bool isActive;
  final int days;

  ExtractBoxDate({
    @required this.title,
    @required this.days,
    this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => testefunction(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: isActive != null ? Colors.indigo[900] : Colors.white,
          border: Border.all(
            color: Colors.indigo[900],
            width: 1.4,
          ),
        ),
        child: Text(title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isActive != null ? Colors.white : Colors.indigo[900],
            )),
      ),
    );
  }

  testefunction() {
    final DateFormat maskDate = new DateFormat('yyyy/MM/dd');
    String dateFormated = maskDate.format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - days));
    _cardExtractBloc.getCardExtract(date: dateFormated);
  }
}
