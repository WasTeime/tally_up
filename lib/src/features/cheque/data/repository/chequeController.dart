import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tally_up/src/core/data/Controller.dart';
import 'package:tally_up/src/features/cheque/models/ChequeModel.dart';
import 'package:tally_up/src/features/cheque/models/ProductModel.dart';

class ChequeController extends Controller {
  final dio = Dio();
  final fnsAPItoken = '23949.zZcGe0JS6TzX85yz2';

  List<ProductModel> _parseChequeProductsToListProductsModel(
    List<dynamic> products,
  ) {
    List<ProductModel> data = [];
    for (var product in products) {
      data.add(ProductModel(
        name: product['name'],
        quantity: product['quantity'],
        price: product['price'] / 100,
      ));
    }
    return data;
  }

  Future<Map<String, dynamic>> _parseChequeFromQRCodeToData({
    required String chequeQRRaw,
  }) async {
    Map<String, dynamic> chequeData = {};
    await dio
        .post(
      'https://proverkacheka.com/api/v1/check/get',
      data: FormData.fromMap({
        'token': fnsAPItoken,
        'qrraw': chequeQRRaw,
      }),
    )
        .then((response) {
      Map<String, dynamic> data = response.data['data']['json'];
      chequeData.addAll({
        'products': _parseChequeProductsToListProductsModel(data['items']),
        'shop_name': data.containsKey("retailPlace")
            ? data['retailPlace']
            : data['user'],
        'shop_address': data['retailPlaceAddress'],
        'date_time': data['dateTime'],
        'cash_sum': data['cashTotalSum'],
        'card_sum': data['ecashTotalSum'],
        'final_sum': data['totalSum'],
        'fn': data['fiscalDriveNumber'],
        'fd': data['fiscalDocumentNumber'],
        'fpd': data['fiscalSign'],
      });
    });
    return chequeData;
  }

  Future createCheque({
    required String chequeQRRaw,
    required DocumentReference eventRef,
  }) async {
    Map<String, dynamic> chequeData =
        await _parseChequeFromQRCodeToData(chequeQRRaw: chequeQRRaw);

    var chequeModel = ChequeModel(
      shopName: chequeData['shop_name'],
      shopAddress: chequeData['shop_address'],
      chequeDateTime: chequeData['date_time'],
      cashSum: chequeData['cash_sum'] / 100,
      cardSum: chequeData['card_sum'] / 100,
      finalSum: chequeData['final_sum'] / 100,
      fn: chequeData['fn'].toString(),
      fd: chequeData['fd'].toString(),
      fpd: chequeData['fpd'].toString(),
    );

    await eventRef.collection('cheques').add(chequeModel.toJson()).then(
      (chequeRef) async {
        for (var product in (chequeData['products'] as List<ProductModel>)) {
          chequeRef.collection('products').add(product.toJson());
        }
      },
    );
  }

  //можно переписать функцию getCollectionDocs с добавлением своей data через callback
  Future getChequeProductsList({
    required DocumentReference chequeRef,
  }) async {
    List<Map<String, dynamic>> productsList = [];
    await chequeRef.collection('products').get().then((productsColSnapshot) {
      for (var productDoc in productsColSnapshot.docs) {
        var data = productDoc.data();
        data.addAll({
          //добавленные данные для экрана
          'id': productsList.length,
          'original_quantity': data['quantity'],
        });
        data['quantity'] = ValueNotifier(data['quantity'] as int);
        productsList.add(data);
      }
    });
    return productsList;
  }

  Future<Map<String, dynamic>> getChequeData({
    required DocumentReference chequeRef,
  }) async {
    Map<String, dynamic> chequeData = {
      'data': await getDocFieldsByRef(chequeRef),
      'products': await getChequeProductsList(chequeRef: chequeRef),
    };
    return chequeData;
  }
}
