import 'package:jiffy/jiffy.dart';

class DataUserModel {
  String email;
  String tel2;
  String birthDate;

  String timestamp;
  String hourSec;

  DataUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    tel2 = json['tel2'];
    birthDate = Jiffy(json['birthDate'].substring(0, 10).replaceAll('-', '/'), "yyyy/MM/dd").format("dd/MM/yyyy");
  }
}
