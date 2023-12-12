import 'package:flutter/material.dart';

class QRResult extends StatelessWidget {
  final String code;
  final Function() closeScreen;

  const QRResult({Key? key, required this.closeScreen, required this.code})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Parse QR Code Data
    final PurchaseInfo purchaseInfo = parseQRCodeData(code);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            IconButton(
              onPressed: () {
                closeScreen();
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "QScanned result",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 24,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "ФД: ${purchaseInfo.fn}",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            Text(
              "ФН: ${purchaseInfo.fiscalNumber}",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            Text(
              "ФП: ${purchaseInfo.fiscalDocument}",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            Text(
              "Сумма: ${purchaseInfo.amount}",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  PurchaseInfo parseQRCodeData(String code) {
    // Implement your logic to parse the QR code data and extract purchase information
    // For simplicity, assuming a specific format in the QR code data
    // You should adjust this based on the actual structure of your QR code data

    List<String> keyValuePairs = code.split('&');
    Map<String, String> dataMap = {};

    for (String pair in keyValuePairs) {
      List<String> keyValue = pair.split('=');
      if (keyValue.length == 2) {
        dataMap[keyValue[0]] = keyValue[1];
      }
    }

    // Assuming the data contains keys like 'fn', 'fp', 'i', 's'
    String fn = dataMap['fn'] ?? '';
    String fiscalNumber = dataMap['i'] ?? '';
    String fiscalDocument = dataMap['fp'] ?? '';
    String amount = dataMap['s'] ?? '';

    return PurchaseInfo(
      fn: fn,
      fiscalNumber: fiscalNumber,
      fiscalDocument: fiscalDocument,
      amount: amount,
    );
  }
}

class PurchaseInfo {
  final String fn;
  final String fiscalNumber;
  final String fiscalDocument;
  final String amount;

  PurchaseInfo({
    required this.fn,
    required this.fiscalNumber,
    required this.fiscalDocument,
    required this.amount,
  });
}
