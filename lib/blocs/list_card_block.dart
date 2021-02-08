import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';

class ListCardBloc extends BlocBase {
  void signIn() async {
    try {
      Map<String, String> data = {
        'grant_type': 'password',
        'scope': 'openid profile vcn vcn_portador',
      };

      Response response = await Dio().post('https://dev-km.eprepay.com.br/oauth2/token',
          data: data,
          options: Options(
            contentType: 'application/x-www-form-urlencoded',
            headers: {"Authorization": 'Basic QVRMbVVvM2FSZ180b1UzTWhVbnlteEdDNjJZYTo1SmF3aHJVZ0R0OXprV0VPM2Zpc0ZCN2hlWUlh'},
          ));

      print(response);
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
