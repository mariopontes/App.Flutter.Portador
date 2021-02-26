import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rxdart/rxdart.dart';

const BASEURL = 'https://api-qa.eprepay.com.br';

class FirstAccessBloc extends BlocBase {
  final _stateController = BehaviorSubject();
  Stream get outState => _stateController.stream;

  Future firstAccessValidate({
    @required cpf,
    @required nome,
    @required nascimento,
    @required senha,
    @required confirmeSenha,
  }) async {
    if (senha != confirmeSenha) {
      _stateController.add('errorPass');
      return;
    }
    _stateController.add('loading');

    var body = {
      'Token': 'C320917F-891F-49D5-A47D-036E073B5AF1',
      'Cpf': cpf = cpf.replaceAll('.', '').replaceAll('-', ''),
      'NomeCompleto': nome,
      'DataNascimento': Jiffy(nascimento, "dd/MM/yyyy").format("yyyy/MM/dd"),
      'Senha': senha,
    };

    try {
      Response response = await Dio().post(
        '$BASEURL/vcn/v1.0.0/portador/validar',
        data: body,
      );

      _stateController.add('success');
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
      _stateController.add('error');
      return null;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _stateController.close();
  }
}
