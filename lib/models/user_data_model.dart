import 'package:jiffy/jiffy.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DataUserModel {
  final maskFone = MaskTextInputFormatter(mask: "(##) # ####-####", filter: {"#": RegExp(r'[0-9]')});

  String email;
  String tel2;
  String birthDate;

  String timestamp;
  String hourSec;

  DataUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    tel2 = maskFone.maskText(json['tel2']);
    birthDate = Jiffy(json['birthDate'].substring(0, 10).replaceAll('-', '/'), "yyyy/MM/dd").format("dd/MM/yyyy");
  }
}
