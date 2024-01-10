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
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: isEnableDivider
          ? const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromARGB(75, 158, 158, 158),
                ),
              ),
            )
          : null,
      child: Row(
        children: [
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(width: 20),
          Expanded(
            child: TextFormField(
              controller: controller,
              readOnly: isReadOnly,
              keyboardType: keyboardType,
              onTap: onTapEvent,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintStyle: const TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 15,
                  color: Color.fromARGB(103, 80, 162, 255),
                ),
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
