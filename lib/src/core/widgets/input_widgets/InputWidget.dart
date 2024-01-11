import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

//!Этот актуальный
class InputWidget extends StatelessWidget {
  final TextEditingController inputController;
  final String? Function(String? value)? formValidationEvent;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final String hintText;
  final Color? hintColor;
  final Color? fillColor;
  final bool autofocus;

  const InputWidget({
    super.key,
    required this.inputController,
    this.formValidationEvent, //todo required
    this.inputFormatters,
    this.keyboardType,
    required this.hintText,
    this.hintColor,
    this.fillColor,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      autofocus: autofocus,
      controller: inputController,
      validator: (value) => formValidationEvent!.call(
        inputFormatters != null
            ? (inputFormatters?.first as MaskTextInputFormatter)
                .getUnmaskedText()
            : value,
      ),
      //todo сделать чтобы при нажатии кнопки принять изменения поле начало валидироваться и обновилось
      // onFieldSubmitted: (value) {
      // formValidationEvent!.call(
      //   (inputFormatters?.first as MaskTextInputFormatter).getUnmaskedText(),
      // );
      // },
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: theme.primaryColorLight),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        hintText: hintText,
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
          color: hintColor ?? Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
        filled: fillColor != null ? true : false,
        fillColor: fillColor ?? Colors.white,
      ),
      style: theme.textTheme.bodyMedium?.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
