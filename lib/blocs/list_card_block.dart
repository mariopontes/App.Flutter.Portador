import 'dart:convert';

import 'package:ESPP_Rewards_App_Portador/models/card_model.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum EyesType { ShowEyes, HiddenEsyes }
const BASEURL = 'https://api-dev.eprepay.com.br';

class CardBloc extends BlocBase {
  String _token;
  String _document;

  final _eyesController = BehaviorSubject();
  Stream get detailsState => _eyesController.stream;

  final _cardController = BehaviorSubject();
  Stream get cardState => _cardController.stream;

  ///-------------------------Functions-----------------------///

  Future getCards() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('access_token') ?? null;
    _document = prefs.getString('document') ?? null;

    try {
      Response response = await Dio().get('$BASEURL/vcn/v1.0.0/portador/listarcartoes/$_document',
          options: Options(
            contentType: 'application/json',
            headers: {"Authorization": 'Bearer $_token'},
          ));

      return response.data['cartoes'];
    } catch (e) {
      print('Erro na busca de cartoes ${e.response.data}');
      return null;
    }
  }

  Future getDetailsCard({String proxy, bool stateEyes}) async {
    stateEyes ? _eyesController.add('show') : _eyesController.add('hidden');

    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('access_token') ?? null;
    _document = prefs.getString('document') ?? null;
    String cardStr = prefs.getString('currentCard') ?? null;

    if (proxy != null) {
      if (cardStr == null) {
        try {
          Response response = await Dio().get('$BASEURL/vcn/v1.0.0/portador/detalhes/$_document/$proxy',
              options: Options(
                contentType: 'application/json',
                headers: {"Authorization": 'Bearer $_token'},
              ));

          final CardModel card = CardModel.fromJson(response.data);
          _cardController.add(card);

          final prefs = await SharedPreferences.getInstance();
          prefs.setString('currentCard', jsonEncode(card));

          print('Current Card Salvo');
        } catch (e) {
          print('Erro ao buscar detalhes do cartão ${e.response.data}');
          return null;
        }
      } else if (jsonDecode(cardStr)['cardSerialNumber'] != proxy) {
        try {
          Response response = await Dio().get('$BASEURL/vcn/v1.0.0/portador/detalhes/$_document/$proxy',
              options: Options(
                contentType: 'application/json',
                headers: {"Authorization": 'Bearer $_token'},
              ));

          final CardModel card = CardModel.fromJson(response.data);
          _cardController.add(card);

          final prefs = await SharedPreferences.getInstance();
          prefs.setString('currentCard', jsonEncode(card));

          print('Current Card Salvo');
        } catch (e) {
          print('Erro ao buscar detalhes do cartão ${e.response.data}');
          return null;
        }
      } else {
        var cardMap = jsonDecode(cardStr) as Map<String, dynamic>;
        final CardModel card = CardModel.fromJson(cardMap);
        _cardController.add(card);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _eyesController.close();
    _cardController.close();
  }
}