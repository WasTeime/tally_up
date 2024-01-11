import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//! активный
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
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        inputFormatters: inputFormatters,
        keyboardType: textInputType,
        controller: inputController,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 20.0,
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              color: Color.fromRGBO(207, 203, 203, 0.989),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              color: Colors.blue.shade400,
              width: 1.5,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black26),
        ),
      ),
    );
  }
}
