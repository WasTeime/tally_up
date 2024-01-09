import 'package:flutter/material.dart';

class EnterChequeManuallyChequeInputField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String hintText;
  final Function()? onTapEvent;
  final TextInputType? keyboardType;
  final bool isReadOnly;
  final bool isEnableDivider;

  const EnterChequeManuallyChequeInputField({
    super.key,
    required this.title,
    required this.controller,
    required this.hintText,
    this.onTapEvent,
    this.keyboardType,
    this.isReadOnly = false,
    this.isEnableDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: isEnableDivider
          ? const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                ),
              ),
            )
          : null,
      child: Row(
        children: [
          Text(title),
          const SizedBox(width: 20),
          Expanded(
            child: TextFormField(
              controller: controller,
              readOnly: isReadOnly,
              keyboardType: keyboardType,
              onTap: onTapEvent,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Поле не должно быть пустым';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
