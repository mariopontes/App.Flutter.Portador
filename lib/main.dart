import 'package:ESPP_Rewards_App_Portador/main_screen.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'blocs/auth_guard_bloc.dart';
import 'blocs/authentication_block.dart';
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
        Bloc((i) => AuthenticationBloc(), singleton: true),
      ],
      child: MaterialApp(
        title: 'App Portador',
        theme: ThemeData(
          accentColor: Colors.white,
          backgroundColor: Colors.indigo[900],
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          '/login': (context) => LoginScreen(),
        },
        home: MainScreen(),
      ),
    );
  }
}
