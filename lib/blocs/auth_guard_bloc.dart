import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthGuardBloc extends BlocBase {
  Future<bool> tokenIsValid() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('access_token') ?? null;

    if (token != null) {
      bool isTokenExpired = JwtDecoder.isExpired(token);

      if (!isTokenExpired) {
        print('Foi encontrado um token válido.');
        return true;
      } else {
        final prefs = await SharedPreferences.getInstance();
        prefs.remove('access_token');
        prefs.remove('document');
        prefs.remove('cardProxy');
        prefs.remove('currentCard');
        prefs.remove('cardContract');
        print('Foi encontrado um token expirado; O token será apagado e você redirecionado para tela de Login');
        return false;
      }
    } else {
      print('Nenhum token encontrado.');
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
