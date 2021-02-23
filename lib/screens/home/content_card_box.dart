import 'package:ESPP_Rewards_App_Portador/blocs/list_card_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContentCardBox extends StatelessWidget {
  final _cardBloc = BlocProvider.getBloc<CardBloc>();

  final int cardStatus;
  final double cardBalance;
  final String cardNumber;
  final String cardContentStatus;
  final String cardDateExpiration;
  final String cardCVV;
  final String cardSerialNumber;
  final bool cardIsOpen;

  ContentCardBox({
    @required this.cardStatus,
    @required this.cardBalance,
    @required this.cardNumber,
    @required this.cardContentStatus,
    @required this.cardIsOpen,
    this.cardDateExpiration,
    this.cardCVV,
    this.cardSerialNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text('Status: ', style: TextStyle(color: Theme.of(context).accentColor)),
                Text(
                  'Cartão ${cardStatus == 1 ? 'Ativado' : cardStatus == 2 ? 'Bloqueado' : 'Cancelado'}',
                  style: TextStyle(
                    color: cardStatus == 1
                        ? Colors.lightGreenAccent[400]
                        : cardStatus == 2
                            ? Colors.redAccent
                            : Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Image.asset('assets/images/logo-card.png', fit: BoxFit.cover),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Saldo : R\$ $cardBalance', style: TextStyle(fontSize: 16, color: Theme.of(context).accentColor)),
            GestureDetector(
              onTap: () => _getDetailsCard(cardSerialNumber, cardIsOpen),
              child: FaIcon(
                cardContentStatus == 'hidden' ? FontAwesomeIcons.solidEyeSlash : FontAwesomeIcons.solidEye,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Text('$cardNumber', style: TextStyle(fontSize: 26, color: Theme.of(context).accentColor, wordSpacing: 5)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Vencimento: ${cardDateExpiration != null ? cardDateExpiration : '*****'}',
                    style: TextStyle(color: Theme.of(context).accentColor)),
                Text('CVV:  ${cardCVV != null ? cardCVV : '****'}', style: TextStyle(color: Theme.of(context).accentColor)),
              ],
            ),
            Image.asset(
              'assets/images/master-card.png',
              fit: BoxFit.cover,
              height: 50,
            ),
          ],
        ),
      ],
    );
  }

  _getDetailsCard(String proxy, bool showContentCard) {
    _cardBloc.getDetailsCard(proxy: proxy, stateEyes: showContentCard);
  }
}
