import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tally_up/src/core/widgets/helper_widgets/ColumnGapWidget.dart';
import 'package:tally_up/src/features/cheque/presentation/widgets/qrscaneroverlay.dart';

class CreateChequeQRScannerScreen extends StatefulWidget {
  const CreateChequeQRScannerScreen({super.key});

  @override
  State<CreateChequeQRScannerScreen> createState() =>
      _CreateChequeQRScannerScreenState();
}

//!если сделать hot restart когда сканер открыт, то видимо dispose у scannerController не успевает вызываться и поэтому возникает ошибка, что сканер уже открыт
class _CreateChequeQRScannerScreenState
    extends State<CreateChequeQRScannerScreen> {
  final MobileScannerController scannerController = MobileScannerController();

  @override
  void dispose() {
    scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isQRCodeFound = false;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            MobileScanner(
              controller: scannerController,
              onDetect: (BarcodeCapture capture) {
                Barcode barcode = capture.barcodes.first;
                if (!isQRCodeFound) {
                  String code = barcode.rawValue!;
                  isQRCodeFound = true;
                  context.go('/cheque', extra: code);
                }
              },
            ),
            QRScannerOverlay(overlayColor: Colors.black.withOpacity(0.5)),
            Align(
              alignment: Alignment.topRight,
              child: CloseButton(
                onPressed: () => context.go('/'),
              ),
            ),
            //todo указать margin половину от низа экрана до области сканирования
            Container(
              margin: const EdgeInsets.only(bottom: 60),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ValueListenableBuilder(
                    valueListenable: scannerController.torchState,
                    builder: (__, torchState, _) {
                      return IconButton(
                        onPressed: () => scannerController.toggleTorch(),
                        icon: torchState == TorchState.on
                            ? const Icon(Icons.flash_off)
                            : const Icon(Icons.flash_on),
                      );
                    },
                  ),
                  const Card(
                    color: Colors.grey,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.qr_code,
                            size: 40,
                            color: Colors.black,
                          ),
                          ColumnGapWidget(),
                          Flexible(
                            child: Text(
                              'Наведите камеру на QR-код на чеке',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const ColumnGapWidget(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Или введите чек",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () => context.go('/chequeEnterManually'),
                        child: const Text(
                          "вручную",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Rubik',
                            decoration: TextDecoration.underline,
                            color: Colors.white,
                            decorationColor: Colors.white,
                            decorationThickness: 1,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
