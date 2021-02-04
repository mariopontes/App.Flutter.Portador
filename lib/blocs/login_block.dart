import 'dart:async';
import 'package:ESPP_Rewards_App_Portador/validators/login_validators.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LoginState { IDLE, LOADING, SUCCESS, FAIL }

class LoginBloc extends BlocBase with LoginValidators {
  LoginBloc() {
    _validateToken();
  }

  final _documentController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<LoginState>();

  Stream<bool> get outSubmitValid => Rx.combineLatest2(outDocument, outPassword, (a, b) => true);
  Stream<String> get outDocument => _documentController.stream.transform(validateDocument);
  Stream<String> get outPassword => _passwordController.stream.transform(validatePassword);
  Function(String) get changeDocument => _documentController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Stream<LoginState> get outState => _stateController.stream;

  String token;
  Map<String, dynamic> decodedToken;

  void submit() async {
    final document = _documentController.value;
    final password = _passwordController.value;

    _stateController.add(LoginState.LOADING);

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

      token = response.data['access_token'];
      _setAccessToken();
      _stateController.add(LoginState.SUCCESS);
    } catch (e) {
      print(e.response);
      _stateController.add(LoginState.FAIL);
    }
  }

  _setAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', token);
    print('Token Gravado');
  }

  Future<void> _validateToken() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('access_token') ?? null;

    if (token != null) {
      bool isTokenExpired = JwtDecoder.isExpired(token);

      if (!isTokenExpired) {
        print('Foi encontrado um token válido.');
        _stateController.add(LoginState.SUCCESS);
      } else {
        final prefs = await SharedPreferences.getInstance();
        prefs.remove('access_token');

        print('Foi encontrado um token expirado; O token será apagado e você redirecionado para tela de Login');
        _stateController.add(LoginState.IDLE);
      }
    } else {
      print('Nenhum token encontrado.');
      _stateController.add(LoginState.IDLE);
    }
  }

  @override
  void dispose() {
    super.dispose();

    _documentController.close();
    _passwordController.close();
    _stateController.close();
  }
}
