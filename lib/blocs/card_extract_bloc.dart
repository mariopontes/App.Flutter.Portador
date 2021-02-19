import 'package:ESPP_Rewards_App_Portador/models/card_extract_model.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

const BASEURL = 'https://api-qa.eprepay.com.br';

enum DayState { Box1, Box2, Box3, Box4 }

class CardExtractBloc extends BlocBase {
  DateFormat maskDate = new DateFormat('yyyy/MM/dd');
  String _token;
  String _document;
  String _cardProxy;
  String _dateFormated;

  Stream<DayState> get outState => _selectedDaysController.stream;
  final _selectedDaysController = BehaviorSubject<DayState>();

  Future getCardExtract({int days}) async {
    days != null
        ? _dateFormated = maskDate.format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - days))
        : _dateFormated = null;

    await this.getParams();

    var body = {
      'proxy': _cardProxy,
      'dataDe': _dateFormated != null ? _dateFormated : maskDate.format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 15)),
      'dataAte': maskDate.format(new DateTime.now()),
    };

    try {
      Response response = await Dio().post('$BASEURL/vcn/v1.0.0/portador/cartao/extrato/$_document',
          data: body,
          options: Options(
            contentType: 'application/json',
            headers: {"Authorization": 'Bearer $_token'},
          ));

      var lista = response.data['extrato']['detalhe_transacoes_new'].map((data) => CardExtractModel.fromJson(data)).toList();
      List extractList = lista;

      return extractList;
    } catch (e) {
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
    _selectedDaysController.close();
  }
}
