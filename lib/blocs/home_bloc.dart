import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBloc extends BlocBase {
  HomeBloc() {
    _getUserLogged();
  }

  String token;
  Map<String, dynamic> decodedToken = {};

  _getUserLogged() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('access_token') ?? null;

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    print(decodedToken);
  }
}
