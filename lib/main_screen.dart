import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'blocs/auth_guard_bloc.dart';
import 'screens/home/home_screen.dart';
import 'screens/login/login_screen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authGuardBloc = BlocProvider.getBloc<AuthGuardBloc>();

    return Container(
      child: FutureBuilder(
        future: authGuardBloc.tokenIsValid(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(color: Colors.indigo[900], child: Center(child: CircularProgressIndicator()));
          } else if (!snapshot.data) {
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
