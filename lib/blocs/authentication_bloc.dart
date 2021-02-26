import 'dart:async';
import 'dart:convert';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../environment/environment.dart';
import '../validators/login_validators.dart';

enum AuthState { IDLE, LOADING, SUCCESS, FAIL }

class AuthenticationBloc extends BlocBase with LoginValidators {
  final _documentController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<AuthState>();

  Stream<bool> get outSubmitValid => Rx.combineLatest2(outDocument, outPassword, (a, b) => true);
  Stream<String> get outDocument => _documentController.stream.transform(validateDocument);
  Stream<String> get outPassword => _passwordController.stream.transform(validatePassword);
  Stream<AuthState> get outState => _stateController.stream;

  Function(String) get changeDocument => _documentController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  void signIn({cpf, senha}) async {
    final document = cpf != null ? cpf : _documentController.value;
    final password = senha != null ? senha : _passwordController.value;

    _stateController.add(AuthState.LOADING);

    try {
      Map<String, String> data = {
        'grant_type': 'password',
        'username': document.replaceAll('.', '').replaceAll('-', ''),
        'password': password,
        'scope': 'openid profile vcn vcn_portador',
      };

      Response response = await Dio().post('$urlLogin/oauth2/token',
          data: data,
          options: Options(
            contentType: 'application/x-www-form-urlencoded',
            headers: {'Authorization': 'Basic ${base64.encode(utf8.encode(scope))}'},
          ));

      _setAccessToken(response.data['access_token']);
      _setDocument(document.replaceAll('.', '').replaceAll('-', ''));
      _stateController.add(AuthState.SUCCESS);
    } catch (e) {
      // if (e is DioError) {
      //   print(jsonDecode(e.response.data));
      // }
      print(e.response.data);
      _stateController.add(AuthState.FAIL);
    }
  }

  void signOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('access_token');
    prefs.remove('document');
    prefs.remove('cardProxy');
    prefs.remove('currentCard');
    prefs.remove('cardContract');
  }

  void _setAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', token);
    print('Token Gravado');
  }

  void _setDocument(String document) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('document', document);
    print('Document Gravado');
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
