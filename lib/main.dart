import 'package:ESPP_Rewards_App_Portador/main_screen.dart';
import 'package:ESPP_Rewards_App_Portador/screens/home/home_screen.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'blocs/auth_guard_bloc.dart';
import 'screens/login/login_screen.dart';

final authGuardBloc = BlocProvider.getBloc<AuthGuardBloc>();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => AuthGuardBloc(), singleton: true),
      ],
      child: MaterialApp(
        title: 'App Portador',
        theme: ThemeData(primaryColor: Colors.pinkAccent),
        debugShowCheckedModeBanner: false,
        routes: {
          '/login': (context) => LoginScreen(),
          '/home': (context) => HomeScreen(),
        },
        home: MainScreen(),
      ),
    );
  }
}
