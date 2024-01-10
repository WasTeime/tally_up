import 'package:flutter/material.dart';
import 'package:tally_up/src/core/widgets/input_widgets/TextButtonWidget.dart';
import 'package:tally_up/src/features/cheque/presentation/widgets/view.dart';

class EnterChequeManuallyProducts extends StatelessWidget {
  const EnterChequeManuallyProducts({super.key});

  //пока это просто заглушка, по сути она не работает, надо прикрутить изменение данных
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final countProducts = ValueNotifier(1);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Card(
            surfaceTintColor: Colors.white,
            elevation: 10,
            shadowColor: Colors.black38,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: ValueListenableBuilder(
                        valueListenable: countProducts,
                        builder: (__, value, _) => ListView.separated(
                          itemCount: value,
                          itemBuilder: (context, index) {
                            return EnterChequeManuallyProductsInputField(
                              countProducts: countProducts,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Container(
                              height: 1,
                              color: Colors.grey.shade400,
                            );
                          },
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        countProducts.value++;
                      },
                      icon: Ink(
                        decoration: const ShapeDecoration(
                          color: Colors.blue, // Цвет фона
                          shape: CircleBorder(),
                        ),
                        child: const SizedBox(
                          width: 44,
                          height: 44,
                          child: Icon(Icons.add, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 50),
        TextButtonWidget(() => null, "Продолжить"),
      ],
    );
  }
}
