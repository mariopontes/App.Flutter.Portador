import 'package:ESPP_Rewards_App_Portador/screens/home/card_loading.dart';
import 'package:ESPP_Rewards_App_Portador/screens/home/content_card_box.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../blocs/list_card_bloc.dart';

class CustomCarousel extends StatefulWidget {
  @override
  _CustomCarouselState createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  final _cardBloc = BlocProvider.getBloc<CardBloc>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _cardBloc.getCards(),
      builder: (context, snapshot) {
        print(snapshot.data);
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
                  _cardBloc.setCurrentCard(snapshot.data[index]);
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
                              final cardFormated = snapshot.data.cardNumber.replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} ");
                              return ContentCardBox(
                                cardBalance: snapshot.data.balance,
                                cardCVV: snapshot.data.cardVerificationValue,
                                cardContentStatus: streamSnapshot.data,
                                cardDateExpiration: snapshot.data.cardExpirationDate,
                                cardIsOpen: false,
                                cardNumber: cardFormated,
                                cardStatus: item['statusCard_Id'],
                              );
                            }
                          }

                          return ContentCardBox(
                            cardBalance: item['balance'],
                            cardContentStatus: streamSnapshot.data,
                            cardIsOpen: true,
                            cardNumber: '**** **** **** ${item['cardLastNumbers']}',
                            cardStatus: item['statusCard_Id'],
                            cardSerialNumber: item['cardSerialNumber'],
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
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 205,
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
            child: CardLoading(),
          );
        }
      },
    );
  }
}
