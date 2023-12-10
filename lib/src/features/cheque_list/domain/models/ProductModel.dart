import 'package:flutter/material.dart';

class Product {
  int id;
  String name;
  ValueNotifier<int> quantity;
  double price;
  Product(this.id, this.name, this.quantity, this.price);

  get length => null;

  double getFinelPrice() {
    return quantity.value * price;
  }

  void setName(String newName) {
    name = newName;
  }
}
