import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CustomCarousel extends StatefulWidget {
  CustomCarousel({Key key}) : super(key: key);

  @override
  _CustomCarouselState createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          height: 225,
          viewportFraction: 0.9,
          initialPage: 0,
          enableInfiniteScroll: false,
          reverse: false,
          autoPlay: false,
        ),
        items: [1, 2].map((i) {
          return Builder(
            builder: (BuildContext context) {
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Status: Cartão bloqueado', style: TextStyle(color: Theme.of(context).accentColor)),
                          Image.asset(
                            'assets/images/logo-card.png',
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                    Text('Saldo : R\$ 100.00', style: TextStyle(fontSize: 16, color: Theme.of(context).accentColor)),
                    Text('**** **** **** 0000', style: TextStyle(fontSize: 26, color: Theme.of(context).accentColor)),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Vencimento: 10/29', style: TextStyle(color: Theme.of(context).accentColor)),
                              Text('CVV: 123', style: TextStyle(color: Theme.of(context).accentColor)),
                            ],
                          ),
                          Image.asset(
                            'assets/images/master-card.png',
                            fit: BoxFit.cover,
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
