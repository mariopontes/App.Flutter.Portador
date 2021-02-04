import 'package:ESPP_Rewards_App_Portador/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'blocs/auth_guard_bloc.dart';
import 'init.dart';
import 'screens/login/login_screen.dart';

final routes = {
  '/login': (context) => LoginScreen(),
  '/home': (context) => HomeScreen(),
};

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  init().then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authGuardBloc = app.get<AuthGuardBloc>();

    return FutureBuilder(
      future: authGuardBloc.tokenIsValid(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(color: Colors.indigo[900], child: Center(child: CircularProgressIndicator()));
        } else {
          return MaterialApp(
            title: 'App Portador',
            theme: ThemeData(primaryColor: Colors.pinkAccent),
            debugShowCheckedModeBanner: false,
            initialRoute: snapshot.data ? '/home' : '/login',
            routes: routes,
          );
        }
      },
    );
  }
}
