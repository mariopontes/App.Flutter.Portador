import 'package:ESPP_Rewards_App_Portador/models/user_data_model.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

const BASEURL = 'https://api-qa.eprepay.com.br';

class DataUserBloc extends BlocBase {
  DateFormat maskDate = new DateFormat('yyyy/MM/dd');
  String _token;
  String _document;

  final _stateController = BehaviorSubject();
  Stream get outState => _stateController.stream;

  Future getDataUser() async {
    await this.getParams();

    try {
      Response response = await Dio().get('$BASEURL/vcn/v1.0.0/portador/detalhes/$_document',
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
