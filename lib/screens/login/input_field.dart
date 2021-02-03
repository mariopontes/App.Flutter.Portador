import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPassword;
  final TextEditingController controller;
  final Stream<String> stream;
  final Function(String) onChanged;

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
          keyboardType: isPassword ? TextInputType.number : TextInputType.emailAddress,
          onChanged: onChanged,
          decoration: InputDecoration(
            errorText: snapshot.hasError ? snapshot.error : null,
            errorStyle: TextStyle(
              fontSize: 15,
              color: Colors.redAccent,
            ),
            labelText: label,
            labelStyle: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white70,
              ),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.white70,
            )),
          ),
        );
      },
    );
  }
}
