import 'package:ESPP_Rewards_App_Portador/blocs/data_user_bloc.dart';
import 'package:ESPP_Rewards_App_Portador/blocs/forgot_bloc.dart';
import 'package:ESPP_Rewards_App_Portador/screens/extract/extract_screen.dart';
import 'package:ESPP_Rewards_App_Portador/screens/first-access/first_access_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'blocs/auth_guard_bloc.dart';
import 'blocs/authentication_bloc.dart';
import 'blocs/list_card_bloc.dart';
import 'blocs/home_bloc.dart';
import 'blocs/card_actions_bloc.dart';
import 'blocs/card_extract_bloc.dart';

import 'screens/data-user/data_user_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/terms/terms_screen.dart';
import 'screens/login/login_screen.dart';
import 'main_screen.dart';

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
        Bloc((i) => CardExtractBloc(), singleton: true),
        Bloc((i) => CardActionsBloc(), singleton: false),
        Bloc((i) => DataUserBloc(), singleton: false),
        Bloc((i) => ForgotBloc(), singleton: false),
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
          '/primeiro-acesso': (context) => FirstAccessScreen(),
          '/home': (context) => HomeScreen(),
          '/termos-uso': (context) => TermsScreen(),
          '/alterações-dados': (context) => DataUserScreen(),
          '/extrato-cartao': (context) => ExtractScreen(),
        },
        localizationsDelegates: [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: [Locale('pt', 'BR')],
        home: MainScreen(),
      ),
    );
  }
}
