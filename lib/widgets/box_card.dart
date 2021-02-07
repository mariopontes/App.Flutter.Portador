import 'package:flutter/material.dart';

class BoxCard extends StatelessWidget {
  final String title;

  BoxCard({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: new Material(
          child: new InkWell(
            onTap: () {
              print("tapped");
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
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: Colors.black38),
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
  }
}
