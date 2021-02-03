import 'package:flutter/material.dart';
import 'screens/login/login_screen.dart';

// final routes = {
//   '/login': (context) => LoginScreen(),
// };

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // String initialRoute = '/login';

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Colors.pinkAccent),
      debugShowCheckedModeBanner: false,
      // initialRoute: initialRoute,
      home: LoginScreen(),
    );
  }
}
