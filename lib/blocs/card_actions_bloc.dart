import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

const BASEURL = 'https://api-dev.eprepay.com.br';
enum AuthState { Success, Fail }

class CardActionsBloc extends BlocBase {
  String _token;
  String _document;
  String _cardProxy;
  String _cardContract;

  Stream<AuthState> get outState => _stateController.stream;
  final _stateController = BehaviorSubject<AuthState>();

  Stream get stateError => _messageError.stream;
  final _messageError = BehaviorSubject();

  Future blockCard() async {
    await this.getParams();

    var body = {
      'proxy': _cardProxy,
      'documento': _document,
      'contrato': _cardContract,
    };

    try {
      Response response = await Dio().post('$BASEURL/vcn/v1.0.0/portador/cartao/bloquear',
          data: body,
          options: Options(
            contentType: 'application/json',
            headers: {"Authorization": 'Bearer $_token'},
          ));

      print(response.data);
      return response.data;
    } catch (e) {
      _messageError.add(e.response.data['mensagem']);
      _stateController.add(AuthState.Fail);
      return null;
    }
  }

  Future unBlockCard() async {
    await this.getParams();

    var body = {
      'proxy': _cardProxy,
      'documento': _document,
      'contrato': _cardContract,
    };

    try {
      Response response = await Dio().post('$BASEURL/vcn/v1.0.0/portador/cartao/ativar',
          data: body,
          options: Options(
            contentType: 'application/json',
            headers: {"Authorization": 'Bearer $_token'},
          ));

      print(response.data);
      return response.data;
    } catch (e) {
      _messageError.add(e.response.data['mensagem']);
      _stateController.add(AuthState.Fail);
      return null;
    }
  }

  Future getParams() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('access_token') ?? null;
    _document = prefs.getString('document') ?? null;
    _cardProxy = prefs.getString('cardProxy') ?? null;
    _cardContract = prefs.getString('cardContract') ?? null;
  }

  @override
  void dispose() {
    super.dispose();

    _stateController.close();
  }
}
