import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CardLoading extends StatelessWidget {
  const CardLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 15,
                    width: 70,
                    child: Shimmer.fromColors(
                      baseColor: Colors.white,
                      highlightColor: Colors.grey,
                      child: Container(
                        color: Colors.white.withAlpha(50),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                    width: 100,
                    child: Shimmer.fromColors(
                      baseColor: Colors.white,
                      highlightColor: Colors.grey,
                      child: Container(
                        color: Colors.white.withAlpha(50),
                        margin: EdgeInsets.symmetric(horizontal: 15),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
                width: 95,
                child: Shimmer.fromColors(
                  baseColor: Colors.white,
                  highlightColor: Colors.grey,
                  child: Container(
                    color: Colors.white.withAlpha(50),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 15,
                width: 125,
                child: Shimmer.fromColors(
                  baseColor: Colors.white,
                  highlightColor: Colors.grey,
                  child: Container(
                    color: Colors.white.withAlpha(50),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
                width: 50,
                child: Shimmer.fromColors(
                  baseColor: Colors.white,
                  highlightColor: Colors.grey,
                  child: Container(
                    color: Colors.white.withAlpha(50),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 27,
            width: 250,
            child: Shimmer.fromColors(
              baseColor: Colors.white,
              highlightColor: Colors.grey,
              child: Container(
                color: Colors.white.withAlpha(50),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                    width: 125,
                    child: Shimmer.fromColors(
                      baseColor: Colors.white,
                      highlightColor: Colors.grey,
                      child: Container(
                        color: Colors.white.withAlpha(50),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                    width: 100,
                    child: Shimmer.fromColors(
                      baseColor: Colors.white,
                      highlightColor: Colors.grey,
                      child: Container(
                        color: Colors.white.withAlpha(50),
                        margin: EdgeInsets.only(top: 5),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
                width: 75,
                child: Shimmer.fromColors(
                  baseColor: Colors.white,
                  highlightColor: Colors.grey,
                  child: Container(
                    color: Colors.white.withAlpha(50),
                    margin: EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
              ),
            ],
          ),

          // SizedBox(
          //   height: 20,
          //   width: 200,
          //   child: Shimmer.fromColors(
          //     baseColor: Colors.white,
          //     highlightColor: Colors.grey,
          //     child: Container(
          //       color: Colors.white.withAlpha(50),
          //       margin: EdgeInsets.symmetric(vertical: 4),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
