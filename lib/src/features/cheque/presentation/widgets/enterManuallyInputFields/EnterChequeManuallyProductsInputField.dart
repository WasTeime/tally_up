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
        child: SizedBox(
          height: 70,
          child: Row(
            children: [
              Flexible(
                child: Column(
                  children: [
                    SizedBox(
                      width: 150,
                      height: 30,
                      child: TextFormField(
                        textAlign: TextAlign.start,
                        controller: nameController,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: "Rubik",
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                          border: InputBorder.none,
                          hintText: "Название",
                          hintStyle: TextStyle(
                            fontSize: 18,
                            fontFamily: "Rubik",
                          ),
                          prefixStyle: TextStyle(
                            color: Color.fromARGB(21, 0, 0, 0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (quantity.value > 1) {
                                quantity.value--;
                              }
                            },
                            child: const Icon(
                              Icons.remove,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          ValueListenableBuilder(
                            valueListenable: quantity,
                            builder: (context, quantity, child) {
                              return Text(
                                "$quantity",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                              onTap: () {
                                quantity.value++;
                              },
                              child: const Icon(Icons.add, color: Colors.blue)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TextFormField(
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: "Rubik",
                    fontWeight: FontWeight.w500,
                  ),
                  controller: sumController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.right,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Цена",
                    hintStyle: TextStyle(fontSize: 18, fontFamily: "Rubik"),
                    prefixStyle: TextStyle(
                      color: Color.fromARGB(21, 0, 0, 0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              const Text(
                "РУБ",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: "Rubik",
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }
}
