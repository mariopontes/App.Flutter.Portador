import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../environment/environment.dart';

class ForgotPassBloc extends BlocBase {
  String messageError;
  final _stateController = BehaviorSubject();
  Stream get outState => _stateController.stream;

  Future sendEmail({@required email}) async {
    _stateController.add('loading');

    var body = {
      'Email': email,
    };

    try {
      Response response = await Dio().post('$urlBase/vcn/v1.0.0/portador/resetsenhaenviar', data: body);

      _stateController.add('success');
      return response.data;
    } catch (e) {
      if (e is DioError) {
        messageError = e.response.data['mensagem'];
      }

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
