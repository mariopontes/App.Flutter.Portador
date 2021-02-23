import 'package:flutter/material.dart';

class DataUserInput extends StatelessWidget {
  final String label;
  final String value;
  final String typeInput;

  DataUserInput({
    @required this.label,
    @required this.value,
    @required this.typeInput,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      style: TextStyle(color: Colors.black87),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        errorStyle: TextStyle(
          fontSize: 14,
          color: Colors.redAccent,
        ),
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 16,
          color: Colors.black87,
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
