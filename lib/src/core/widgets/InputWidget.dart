import 'package:flutter/material.dart';

//!Этот актуальный
//разница, что тут textFormField, потом надо будет в авторизации заменить на этот виджет
class InputWidget extends StatelessWidget {
  final TextEditingController inputController;
  final String hintText;
  const InputWidget(
      {super.key, required this.inputController, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        hintText: hintText,
      ),
      controller: inputController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Введите название группы';
        }
        return null;
      },
    );
  }
}
