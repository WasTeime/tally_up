import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tally_up/src/core/widgets/input_widgets/TextButtonWidget.dart';
import 'package:tally_up/src/features/cheque/presentation/widgets/view.dart';

class EnterChequeManuallyCheque extends StatelessWidget {
  const EnterChequeManuallyCheque({super.key});

  void _selectDate({
    required BuildContext context,
    required TextEditingController controller,
  }) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now(),
      firstDate: DateTime(2022),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
  }

  void _selectTime({
    required BuildContext context,
    required TextEditingController controller,
  }) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime == null) return;
    controller.text = '${pickedTime.hour}:${pickedTime.minute}';
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final dateController = TextEditingController();
    final timeController = TextEditingController();
    final sumController = TextEditingController();
    final fnController = TextEditingController();
    final fdController = TextEditingController();
    final fpdController = TextEditingController();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Card(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                EnterChequeManuallyChequeInputField(
                  title: "Дата:",
                  hintText: "Укажите дату чека",
                  isReadOnly: true,
                  controller: dateController,
                  onTapEvent: () => _selectDate(
                    context: context,
                    controller: dateController,
                  ),
                ),
                EnterChequeManuallyChequeInputField(
                  title: "Время:",
                  hintText: "Укажите время чека",
                  isReadOnly: true,
                  controller: timeController,
                  onTapEvent: () => _selectTime(
                    context: context,
                    controller: timeController,
                  ),
                ),
                EnterChequeManuallyChequeInputField(
                  title: "Итого:",
                  hintText: "Введите сумму чека",
                  keyboardType: TextInputType.number,
                  controller: sumController,
                ),
                EnterChequeManuallyChequeInputField(
                  title: "ФН№:",
                  hintText: "Или ФН",
                  keyboardType: TextInputType.number,
                  controller: fnController,
                ),
                EnterChequeManuallyChequeInputField(
                  title: "ФД№:",
                  hintText: "Или ФД",
                  keyboardType: TextInputType.number,
                  controller: fdController,
                ),
                EnterChequeManuallyChequeInputField(
                  title: "ФПД:",
                  hintText: "ФП или ФП№",
                  keyboardType: TextInputType.number,
                  controller: fpdController,
                  isEnableDivider: false,
                ),
              ],
            ),
          ),
        ),
        TextButtonWidget(
          () => null,
          "Продолжить",
        ),
      ],
    );
  }
}
