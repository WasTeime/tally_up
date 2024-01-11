import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputFieldWidget extends StatelessWidget {
  final String hint;
  final TextEditingController inputController;
  final bool obscure;
  String? errorMessage;
  List<TextInputFormatter>? inputFormatters;

  InputFieldWidget(
    this.hint,
    this.inputController, {
    super.key,
    this.obscure = false,
    this.errorMessage,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: inputFormatters,
      controller: inputController,
      obscureText: obscure,
      decoration: InputDecoration(
        errorText: errorMessage,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(15),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
            color: Color.fromRGBO(207, 203, 203, 0.989),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 3,
          ),
        ),
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFFD3E8FF)),
      ),
      keyboardType: TextInputType.number,
    );
  }
}
