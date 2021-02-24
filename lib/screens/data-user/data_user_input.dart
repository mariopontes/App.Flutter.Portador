import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DataUserInput extends StatelessWidget {
  final maskFone = MaskTextInputFormatter(mask: "(##) # ####-####", filter: {"#": RegExp(r'[0-9]')});
  final birthDate = MaskTextInputFormatter(mask: "##/##/####", filter: {"#": RegExp(r'[0-9]')});
  final maskPassword = MaskTextInputFormatter(mask: "####", filter: {"#": RegExp(r'[0-9]')});

  final String label;
  final String typeInput;
  final TextEditingController controller;
  final Function validators;

  DataUserInput({
    @required this.label,
    @required this.controller,
    @required this.typeInput,
    this.validators,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validators,
      obscureText: typeInput == 'senha' ? true : false,
      style: TextStyle(color: Colors.black87),
      keyboardType: typeInput == 'email'
          ? TextInputType.emailAddress
          : typeInput == 'celular'
              ? TextInputType.phone
              : TextInputType.number,
      inputFormatters: [
        if (typeInput == 'celular') maskFone else if (typeInput == 'nascimento') birthDate else if (typeInput == 'senha') maskPassword
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
          color: Colors.black87,
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
}
