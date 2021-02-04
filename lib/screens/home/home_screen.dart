import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _streamController = StreamController();
  var decodedToken = {};

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  @override
  void initState() {
    super.initState();
    getToken();
  }

  void getToken() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('access_token') ?? null;

    decodedToken = JwtDecoder.decode(token);
    _streamController.sink.add(decodedToken);
    // print(decodedToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: _streamController.stream,
          initialData: {},
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                '${snapshot.data['given_name']}',
              );
            } else {
              return Text('');
            }
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.topCenter,
        color: Colors.indigo[900],
      ),
    );
  }
}
