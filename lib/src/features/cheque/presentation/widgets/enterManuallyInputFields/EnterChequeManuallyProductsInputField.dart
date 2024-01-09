import 'package:flutter/material.dart';

class EnterChequeManuallyProductsInputField extends StatelessWidget {
  final ValueNotifier countProducts;

  const EnterChequeManuallyProductsInputField({
    super.key,
    required this.countProducts,
  });

  @override
  Widget build(BuildContext context) {
    var quantity = ValueNotifier(1);
    final nameController = TextEditingController();
    final sumController = TextEditingController();

    return Dismissible(
      key: UniqueKey(),
      background: Container(color: Colors.red),
      onDismissed: (direction) => countProducts.value--,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Flexible(
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Название",
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (quantity.value > 1) {
                            quantity.value--;
                          }
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.blue,
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: quantity,
                        builder: (context, quantity, child) {
                          return Text("$quantity",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18));
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          quantity.value++;
                        },
                        icon: const Icon(Icons.add, color: Colors.blue),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: TextFormField(
                controller: sumController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.right,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Цена",
                ),
              ),
            ),
            const SizedBox(width: 5),
            const Text("РУБ")
          ],
        ),
      ),
    );
  }
}
