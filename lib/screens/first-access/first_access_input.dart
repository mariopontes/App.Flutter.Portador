import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirstAccessInput extends StatelessWidget {
  final String label;
  final String type;
  final Function validators;
  final TextEditingController controller;

  final maskCpf = MaskTextInputFormatter(mask: "###.###.###-##", filter: {"#": RegExp(r'[0-9]')});
  final maskFone = MaskTextInputFormatter(mask: "(##) # ####-####", filter: {"#": RegExp(r'[0-9]')});
  final maskDate = MaskTextInputFormatter(mask: "##/##/####", filter: {"#": RegExp(r'[0-9]')});
  final maskPassword = MaskTextInputFormatter(mask: "####", filter: {"#": RegExp(r'[0-9]')});

  FirstAccessInput({
    @required this.label,
    @required this.validators,
    @required this.type,
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validators,
      style: TextStyle(color: Colors.black87),
      obscureText: type == 'senha' ? true : false,
      keyboardType: setKeyBoard(),
      inputFormatters: [
        if (type == 'cpf') maskCpf,
        if (type == 'nascimento') maskDate,
        if (type == 'senha') maskPassword,
        if (type == 'nome') LengthLimitingTextInputFormatter(40),
      ],
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        errorStyle: TextStyle(
          fontSize: 13,
          color: Colors.redAccent,
        ),
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.redAccent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black87,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  setKeyBoard() {
    if (type == 'cpf' || type == 'senha') return TextInputType.number;
    if (type == 'nome') return TextInputType.text;
    if (type == 'nascimento') return TextInputType.datetime;
    if (type == 'email') return TextInputType.emailAddress;
  }
}
