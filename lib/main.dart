import 'package:ESPP_Rewards_App_Portador/main_screen.dart';
import 'package:ESPP_Rewards_App_Portador/screens/data-user/data_user_screen.dart';
import 'package:ESPP_Rewards_App_Portador/screens/home/home_screen.dart';
import 'package:ESPP_Rewards_App_Portador/screens/terms/terms_screen.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'blocs/auth_guard_bloc.dart';
import 'blocs/authentication_block.dart';
import 'blocs/list_card_block.dart';
import 'screens/login/login_screen.dart';
import 'blocs/home_bloc.dart';

final authGuardBloc = BlocProvider.getBloc<AuthGuardBloc>();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => AuthGuardBloc(), singleton: true),
        Bloc((i) => AuthenticationBloc(), singleton: true),
        Bloc((i) => HomeBloc(), singleton: true),
        Bloc((i) => CardBloc(), singleton: true),
      ],
      child: MaterialApp(
        title: 'App Portador',
        navigatorKey: navigatorKey,
        theme: ThemeData(
            accentColor: Colors.white,
            backgroundColor: Colors.indigo[900],
            appBarTheme: AppBarTheme(
              color: Colors.indigo[900],
            )),
        debugShowCheckedModeBanner: false,
        routes: {
          '/login': (context) => LoginScreen(),
          '/home': (context) => HomeScreen(),
          '/termos-uso': (context) => TermsScreen(),
          '/alterações-dados': (context) => DataUserScreen(),
        },
        home: MainScreen(),
      ),
    );
  }
}
