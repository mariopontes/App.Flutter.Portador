import 'package:ESPP_Rewards_App_Portador/models/user_data_model.dart';
import 'package:ESPP_Rewards_App_Portador/validators/data_user_validators.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../environment/environment.dart';

class DataUserBloc extends BlocBase with DataUserValidators {
  DateFormat maskDate = new DateFormat('yyyy/MM/dd');
  String _token;
  String _document;
  String messageError;

  final _stateController = BehaviorSubject();
  Stream get outState => _stateController.stream;

  Future getDataUser() async {
    await this.getParams();

    try {
      Response response = await Dio().get('$urlBase/vcn/v1.0.0/portador/detalhes/$_document',
          options: Options(
            contentType: 'application/json',
            headers: {"Authorization": 'Bearer $_token'},
          ));

      final DataUserModel dataUser = DataUserModel.fromJson(response.data['portador']);

      return dataUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future updateDataUser({@required email, @required celular, @required nascimento}) async {
    await this.getParams();

    var body = {
      "documento": _document,
      "DataNascimento": nascimento,
      "Celular": celular,
      "Email": email,
    };

    try {
      Response response = await Dio().post('$urlBase/vcn/v1.0.0/portador/atualizar',
          data: body,
          options: Options(
            contentType: 'application/json',
            headers: {"Authorization": 'Bearer $_token'},
          ));

      _stateController.add('success1');
      return response.data;
    } catch (e) {
      _stateController.add('error');
      return null;
    }
  }

  Future updatePasswordUser({@required senha, @required novaSenha, @required confirmacaoNovaSenha}) async {
    if (novaSenha == confirmacaoNovaSenha) {
      await this.getParams();

      var body = {
        "CPF": _document,
        "SenhaAtual": senha,
        "NovaSenha": novaSenha,
      };

      try {
        Response response = await Dio().post('$urlBase/vcn/v1.0.0/portador/alterarsenha',
            data: body,
            options: Options(
              contentType: 'application/json',
              headers: {"Authorization": 'Bearer $_token'},
            ));

        _stateController.add('success2');
        return response.data;
      } catch (e) {
        if (e is DioError) {
          messageError = e.response.data['mensagem'];
        }

        _stateController.add('error');
        return null;
      }
    } else {
      _stateController.add('error');
      messageError = 'A senhas não conferem, verifique e tente novamente';
    }
  }

  Future getParams() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('access_token') ?? null;
    _document = prefs.getString('document') ?? null;
  }

  @override
  void dispose() {
    super.dispose();
    _stateController.close();
  }
}
