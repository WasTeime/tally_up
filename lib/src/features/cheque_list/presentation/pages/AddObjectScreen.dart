import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:tally_up/src/core/widgets/view.dart';
import 'package:tally_up/src/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';

class Product {
  int id;
  String name;
  int quantity;
  double finalPrice;
  double price;
  Product(this.id, this.name, this.quantity, this.finalPrice, this.price);

  void updatePrice() {
    finalPrice = quantity * price;
  }

  void setName(String newName) {
    name = newName;
  }
}

class AddObjectScreen extends StatefulWidget {
  const AddObjectScreen({super.key});

  @override
  State<AddObjectScreen> createState() => _AddObjectScreenState();
}

class _AddObjectScreenState extends State<AddObjectScreen> {
  final List<Product> products = [
    Product(1, "Чоколадка Милка", 1, 54, 54),
    Product(2, "CoolCola", 1, 10, 10),
    Product(3, "Негр", 1, 20, 20),
  ];

  get code => null;

  Widget _had() {
    final theme = Theme.of(context);
    return Container(
        margin: const EdgeInsets.only(right: 30, top: 45),
        width: 500,
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_back_rounded,
                size: 30,
                color: Color(0xFF0079FF),
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            Text(
              'Ввести чек вучную',
              style: theme.textTheme.headlineMedium
                  ?.copyWith(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }

  Widget _prodList() {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(left: 25, right: 25, top: 120, bottom: 40),
      height: 352,
      width: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 48,
            offset: Offset(4, 8),
          ),
        ],
      ),
      child: ListView.separated(
        itemCount: products.length,
        separatorBuilder: (context, index) => const Divider(
          height: 1,
        ),
        itemBuilder: (context, index) {
          return ListTile(
            title: Align(
              alignment: Alignment.bottomLeft,
              child: TextFormField(
                initialValue: products[index].name,
                style: theme.textTheme.headlineMedium?.copyWith(fontSize: 15),
                onChanged: (newValue) {
                  setState(() {
                    products[index].setName(newValue);
                  });
                },
                decoration: const InputDecoration(),
              ),
            ),
            subtitle: Align(
              alignment: Alignment.topLeft,
              child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.remove,
                    color: Color(0xFF0079FF),
                  ),
                  onPressed: () {
                    setState(() {
                      if (products[index].quantity > 0) {
                        products[index].quantity--;
                        products[index].updatePrice();
                      }
                    });
                  },
                ),
                Text(
                  products[index].quantity.toString(),
                  style: theme.textTheme.headlineMedium?.copyWith(fontSize: 15),
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Color(0xFF0079FF)),
                  onPressed: () {
                    setState(() {
                      products[index].quantity++;
                      products[index].updatePrice();
                    });
                  },
                ),
              ]),
            ),
            trailing: Container(
              width: 70,
              height: 500,
              margin: EdgeInsets.only(top: 1),
              child: TextFormField(
                initialValue: '${products[index].finalPrice} РУБ',
                style: theme.textTheme.headlineMedium?.copyWith(fontSize: 15),
                onChanged: (newValue) {
                  setState(() {
                    newValue = newValue.replaceAll(" РУБ",
                        ""); //сумму можно ввести вручную, но она не изменяется при изменении количества, пока не знаю, как исправить.
                    products[index].finalPrice = double.parse(newValue);
                    products[index].updatePrice();
                  });
                },
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _addButton() {
    return Container(
        margin: const EdgeInsets.only(left: 165, top: 450),
        child: FloatingActionButton(
          backgroundColor: Color(0xFF0079FF),
          mini: true,
          shape: CircleBorder(),
          onPressed: () {
            setState(() {
              products.add(Product(0, "", 0, 0, 0));
            });
          },
          child: const Icon(
            Icons.add_rounded,
            color: Colors.white,
            size: 30,
          ),
        ));
  }

  Widget _buttonNext() {
    return Container(
      margin: const EdgeInsets.only(left: 120, top: 700),
      child: TextButtonWidget(
          () => {context.read<SignInBloc>().add(SignIn(code!))}, "Продолжить"),
    );
  }

  @override
  Widget build(BuildContext context) {
    backgroundColor:
    const Color.fromARGB(255, 218, 235, 255);
    return Scaffold(
      body: Stack(
        children: [
          _had(),
          _prodList(),
          _addButton(),
          NavigIconsBar(),
          _buttonNext()
        ],
      ),
    );
  }
}
