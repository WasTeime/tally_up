import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchBarWidget extends StatelessWidget {
  final String? hint;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;
  final TextEditingController? inputController;

  const SearchBarWidget({
    super.key,
    this.hint,
    this.inputFormatters,
    this.inputController,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: inputFormatters,
      keyboardType: textInputType,
      controller: inputController,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        fillColor: Colors.white,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          borderSide: BorderSide(
            color: Color.fromRGBO(207, 203, 203, 0.989),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 3,
          ),
        ),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black),
      ),
    );
  }
}
