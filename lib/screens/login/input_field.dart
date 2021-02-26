import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPassword;
  final TextEditingController controller;
  final Stream<String> stream;
  final Function(String) onChanged;

  final maskCpf = MaskTextInputFormatter(mask: "###.###.###-##", filter: {"#": RegExp(r'[0-9]')});

  InputField({
    @required this.label,
    @required this.controller,
    @required this.stream,
    @required this.onChanged,
    this.icon,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot) {
        return TextFormField(
          controller: controller,
          style: TextStyle(color: Colors.white),
          obscureText: isPassword ? true : false,
          keyboardType: TextInputType.number,
          onChanged: onChanged,
          inputFormatters: isPassword ? [new LengthLimitingTextInputFormatter(4)] : [new LengthLimitingTextInputFormatter(14), maskCpf],
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 8),
            errorStyle: TextStyle(
              fontSize: 14,
              color: Colors.redAccent,
            ),
            labelText: label,
            labelStyle: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white70,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white70,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white70,
              ),
            ),
          ),
        );
      },
    );
  }
}
