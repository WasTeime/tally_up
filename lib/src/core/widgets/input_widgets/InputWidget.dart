import 'package:flutter/material.dart';

//!Этот актуальный
//разница, что тут textFormField, потом надо будет в авторизации заменить на этот виджет
class InputWidget extends StatelessWidget {
  final TextEditingController inputController;
  final String hintText;
  final Color mainColor;
  final Color hintColor;
  const InputWidget(
      {super.key,
      required this.inputController,
      required this.hintText,
      required this.mainColor,
      required this.hintColor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.bottom,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        hintText: hintText,
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
            color: hintColor, fontSize: 17, fontWeight: FontWeight.w500),
        filled: true,
        fillColor: mainColor,
      ),
      style: theme.textTheme.bodyMedium
          ?.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
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
