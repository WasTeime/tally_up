import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:tally_up/src/core/widgets/view.dart';
import 'package:tally_up/src/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';

class Product {
  String name;
  int quantity;
  double price;
  double itemPrice;
  Product(this.name, this.quantity, this.price, this.itemPrice);

  void updatePrice() {
    price = quantity * itemPrice;
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
  final List<Product> _items = [
    Product("Чоколадка Милка", 1, 54, 54),
    Product("CoolCola", 1, 10, 10),
    Product("Негр", 1, 20, 20),
  ];

  get code => null;

  Widget _had() {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(left: 90, right: 30, top: 50),
      child: Text(
        'Ввести чек вучную',
        style: theme.textTheme.headlineLarge,
        textAlign: TextAlign.center,
      ),
    );
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
        itemCount: _items.length,
        separatorBuilder: (context, index) => Divider(
          height: 1,
        ),
        itemBuilder: (context, index) {
          return ListTile(
            title: Align(
              alignment: Alignment.bottomLeft,
              child: TextFormField(
                initialValue: _items[index].name,
                style: theme.textTheme.displayLarge,
                onChanged: (newValue) {
                  setState(() {
                    _items[index].setName(newValue);
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
                      if (_items[index].quantity > 0) {
                        _items[index].quantity--;
                        _items[index].updatePrice();
                      }
                    });
                  },
                ),
                Text(
                  _items[index].quantity.toString(),
                  style: theme.textTheme.displayLarge,
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Color(0xFF0079FF)),
                  onPressed: () {
                    setState(() {
                      _items[index].quantity++;
                      _items[index].updatePrice();
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
                initialValue: '${_items[index].price} РУБ',
                style: theme.textTheme.displayLarge,
                onChanged: (newValue) {
                  setState(() {
                    newValue = newValue.replaceAll(" РУБ", ""); //сумму можно ввести вручную, но она не изменяется при изменении количества, пока не знаю, как исправить.
                    _items[index].price = double.parse(newValue);
                    _items[index].updatePrice();
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
        margin: EdgeInsets.only(left: 165, top: 450),
        child: FloatingActionButton(
          backgroundColor: Color(0xFF0079FF),
          mini: true,
          shape: CircleBorder(),
          onPressed: () {
            setState(() {
              _items.add(Product("", 0, 0, 0));
            });
          },
          child: Icon(
            Icons.add_rounded,
            color: Colors.white,
            size: 30,
          ),
        ));
  }

  Widget _buttonNext() {
    return Container(
      margin: EdgeInsets.only(left: 120, top: 700),
      child: TextButtonWidget(
          () => {context.read<SignInBloc>().add(SignIn(code!))}, "Продолжить"),
    );
  }

  @override
  Widget build(BuildContext context) {
    backgroundColor:
    Color.fromARGB(255, 218, 235, 255);
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
