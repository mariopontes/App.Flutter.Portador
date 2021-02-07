import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../validators/login_validators.dart';

enum AuthState { IDLE, LOADING, SUCCESS, FAIL }

class AuthenticationBloc extends BlocBase with LoginValidators {
  final _documentController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<AuthState>();

  Stream<bool> get outSubmitValid => Rx.combineLatest2(outDocument, outPassword, (a, b) => true);
  Stream<String> get outDocument => _documentController.stream.transform(validateDocument);
  Stream<String> get outPassword => _passwordController.stream;
  Stream<AuthState> get outState => _stateController.stream;

  Function(String) get changeDocument => _documentController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  void signIn() async {
    final document = _documentController.value;
    final password = _passwordController.value;

    _stateController.add(AuthState.LOADING);

    try {
      Map<String, String> data = {
        'grant_type': 'password',
        'username': document,
        'password': password,
        'scope': 'openid profile vcn vcn_portador',
      };

      Response response = await Dio().post('https://dev-km.eprepay.com.br/oauth2/token',
          data: data,
          options: Options(
            contentType: 'application/x-www-form-urlencoded',
            headers: {"Authorization": 'Basic QVRMbVVvM2FSZ180b1UzTWhVbnlteEdDNjJZYTo1SmF3aHJVZ0R0OXprV0VPM2Zpc0ZCN2hlWUlh'},
          ));

      _setAccessToken(response.data['access_token']);
      _stateController.add(AuthState.SUCCESS);
    } catch (e) {
      // if (e is DioError) {
      //   print(jsonDecode(e.response.data));
      // }
      print(e);
      _stateController.add(AuthState.FAIL);
    }
  }

  void signOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('access_token');
  }

  void _setAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', token);
    print('Token Gravado');
  }

  Future getTokenDecoded() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('access_token') ?? null;
    return JwtDecoder.decode(token);
  }

  @override
  void dispose() {
    super.dispose();

    _documentController.close();
    _passwordController.close();
    _stateController.close();
  }
}
