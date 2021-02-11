import 'package:ESPP_Rewards_App_Portador/models/card_extract_model.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

const BASEURL = 'https://api-qa.eprepay.com.br';

enum AuthState { Success, Fail }

class CardExtractBloc extends BlocBase {
  String _token;
  String _document;
  String _cardProxy;

  Stream<AuthState> get outState => _stateController.stream;
  final _stateController = BehaviorSubject<AuthState>();

  Stream get stateError => _messageError.stream;
  final _messageError = BehaviorSubject();

  Future getCardExtract() async {
    _stateController.add(AuthState.Success);

    await this.getParams();

    var body = {
      'proxy': _cardProxy,
      'dataDe': '20210111',
      'dataAte': '20210211',
    };

    try {
      Response response = await Dio().post('$BASEURL/vcn/v1.0.0/portador/cartao/extrato/$_document',
          data: body,
          options: Options(
            contentType: 'application/json',
            headers: {"Authorization": 'Bearer $_token'},
          ));

      // print(jsonDecode(response.data['extrato']['detalhe_transacoes_new'].map((data) => CardExtractModel.fromJson(data)).toList()));
      var lista = response.data['extrato']['detalhe_transacoes_new'].map((data) => CardExtractModel.fromJson(data)).toList();

      // print(lista[0].timestamp);

      List extractList = lista;

      return extractList;
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
  }

  @override
  void dispose() {
    super.dispose();

    _stateController.close();
  }
}
