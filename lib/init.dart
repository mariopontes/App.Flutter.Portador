import 'package:flutter/services.dart';
import 'app.dart';
import 'blocs/auth_guard_bloc.dart';

Future<void> init() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final authGuardBloc = AuthGuardBloc();

  app.registerSingleton(authGuardBloc);
}
