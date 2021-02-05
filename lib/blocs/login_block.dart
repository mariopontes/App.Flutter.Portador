import 'dart:async';
// import 'dart:convert';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../validators/login_validators.dart';

enum LoginState { IDLE, LOADING, SUCCESS, FAIL }

class LoginBloc extends BlocBase with LoginValidators {
  final _documentController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<LoginState>();

  Stream<bool> get outSubmitValid => Rx.combineLatest2(outDocument, outPassword, (a, b) => true);
  Stream<String> get outDocument => _documentController.stream.transform(validateDocument);
  Stream<String> get outPassword => _passwordController.stream;
  Stream<LoginState> get outState => _stateController.stream;

  Function(String) get changeDocument => _documentController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

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

      _setAccessToken(response.data['access_token']);
      _stateController.add(LoginState.SUCCESS);
    } catch (e) {
      // if (e is DioError) {
      //   print(jsonDecode(e.response.data));
      // }
      print(e);
      _stateController.add(LoginState.FAIL);
    }
  }

  _setAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', token);
    print('Token Gravado');
  }

  @override
  void dispose() {
    super.dispose();

    _documentController.close();
    _passwordController.close();
    _stateController.close();
  }
}
