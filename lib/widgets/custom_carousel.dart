import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../blocs/list_card_block.dart';

class CustomCarousel extends StatefulWidget {
  @override
  _CustomCarouselState createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  final _cardBloc = BlocProvider.getBloc<CardBloc>();
  bool eyesIsOpen = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _cardBloc.getCards(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return CarouselSlider(
              options: CarouselOptions(
                height: 225,
                viewportFraction: 0.9,
                initialPage: 0,
                enableInfiniteScroll: false,
                reverse: false,
                autoPlay: false,
                onPageChanged: (index, reason) {
                  eyesIsOpen = false;
                  _cardBloc.getDetailsCard(stateEyes: false);
                },
              ),
              items: snapshot.data.map<Widget>((item) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(108, 201, 229, 1),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: StreamBuilder(
                    stream: _cardBloc.detailsState,
                    initialData: 'hidden',
                    builder: (streamContext, streamSnapshot) {
                      return StreamBuilder(
                        stream: _cardBloc.cardState,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (streamSnapshot.data == 'show') {
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
                                            'Cartão ${item['statusCard_Id'] == 1 ? 'Ativado' : item['statusCard_Id'] == 2 ? 'Bloqueado' : 'Cancelado'}',
                                            style: TextStyle(
                                              color: item['statusCard_Id'] == 1
                                                  ? Colors.lightGreenAccent[400]
                                                  : item['statusCard_Id'] == 2
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
                                      Text('Saldo : R\$ ${snapshot.data.balance}',
                                          style: TextStyle(fontSize: 16, color: Theme.of(context).accentColor)),
                                      GestureDetector(
                                        onTap: () => getDetailsCard(),
                                        child: FaIcon(
                                          streamSnapshot.data == 'hidden' ? FontAwesomeIcons.solidEyeSlash : FontAwesomeIcons.solidEye,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text('${snapshot.data.cardNumber}',
                                      style: TextStyle(fontSize: 26, color: Theme.of(context).accentColor, wordSpacing: 5)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Vencimento: ${snapshot.data.cardExpirationDate}',
                                              style: TextStyle(color: Theme.of(context).accentColor)),
                                          Text('CVV:  ${snapshot.data.cardVerificationValue}',
                                              style: TextStyle(color: Theme.of(context).accentColor)),
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
                          }

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
                                        'Cartão ${item['statusCard_Id'] == 1 ? 'Ativado' : item['statusCard_Id'] == 2 ? 'Bloqueado' : 'Cancelado'}',
                                        style: TextStyle(
                                          color: item['statusCard_Id'] == 1
                                              ? Colors.lightGreenAccent[400]
                                              : item['statusCard_Id'] == 2
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
                                  Text('Saldo : R\$ ${item['balance']}', style: TextStyle(fontSize: 16, color: Theme.of(context).accentColor)),
                                  GestureDetector(
                                    onTap: () => getDetailsCard(proxy: item['cardSerialNumber']),
                                    child: StreamBuilder(
                                      initialData: 'hidden',
                                      stream: _cardBloc.detailsState,
                                      builder: (context, snapshot) {
                                        return FaIcon(
                                          snapshot.data == 'hidden' ? FontAwesomeIcons.solidEyeSlash : FontAwesomeIcons.solidEye,
                                          color: Colors.white,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Text('**** **** **** ${item['cardLastNumbers']}',
                                  style: TextStyle(fontSize: 26, color: Theme.of(context).accentColor, wordSpacing: 18)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Vencimento: ****', style: TextStyle(color: Theme.of(context).accentColor)),
                                      Text('CVV: ****', style: TextStyle(color: Theme.of(context).accentColor)),
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
                        },
                      );
                    },
                  ),
                );
              }).toList(),
            );
          }
          return Center(
            child: Text(
              'Falha na busca dos cartões...',
              style: TextStyle(fontSize: 16, color: Colors.redAccent[400]),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  getDetailsCard({String proxy}) {
    eyesIsOpen = !eyesIsOpen;

    _cardBloc.getDetailsCard(proxy: proxy, stateEyes: eyesIsOpen);
  }
}
