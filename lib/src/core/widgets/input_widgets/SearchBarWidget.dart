import 'dart:math';

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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        height: 50,
        child: TextField(
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.bottom,
          inputFormatters: inputFormatters,
          keyboardType: textInputType,
          controller: inputController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(45.0)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(45.0)),
              borderSide: BorderSide(
                color: Color.fromRGBO(207, 203, 203, 0.989),
                width: 1,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(45.0)),
              borderSide: BorderSide(
                color: Colors.blue,
                width: 3,
              ),
            ),
            filled: true, // Устанавливаем заполнение
            fillColor: Colors.white,
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.black26),
          ),
        ),
      ),
    );
  }
}
