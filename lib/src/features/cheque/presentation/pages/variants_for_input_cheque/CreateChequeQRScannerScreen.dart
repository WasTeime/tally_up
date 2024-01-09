import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tally_up/src/core/widgets/helper_widgets/ColumnGapWidget.dart';
import 'package:tally_up/src/features/cheque/presentation/bloc/bloc/cheque_bloc.dart';
import 'package:tally_up/src/features/cheque/presentation/widgets/qrscaneroverlay.dart';

class CreateChequeQRScannerScreen extends StatefulWidget {
  final DocumentReference eventRef;

  const CreateChequeQRScannerScreen({
    super.key,
    required this.eventRef,
  });

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
    bool isFlashOn = false;
    final chequeBloc = ChequeBloc(eventRef: widget.eventRef);

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
                  chequeBloc.add(CreateCheque(chequeQRRaw: code));
                }
              },
            ),
            QRScannerOverlay(overlayColor: Colors.black.withOpacity(0.5)),
            Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () => context.go('/'),
                  icon: const Icon(Icons.close, color: Colors.white, size: 40),
                )),
            //todo указать margin половину от низа экрана до области сканирования
            Container(
              margin: const EdgeInsets.only(bottom: 60),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ValueListenableBuilder(
                    valueListenable: scannerController.torchState,
                    builder: (context, torchState, _) {
                      return IconButton(
                        onPressed: () {
                          if (torchState == TorchState.on) {
                            scannerController.toggleTorch();
                          } else {
                            scannerController.toggleTorch();
                          }
                        },
                        icon: torchState == TorchState.on
                            ? const Icon(Icons.flash_off,
                                color: Colors.white, size: 40)
                            : const Icon(
                                Icons.flash_on,
                                color: Colors.white,
                                size: 40,
                              ),
                      );
                    },
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Color.fromARGB(207, 255, 255, 255),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.qr_code,
                            size: 55,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              'Наведите камеру на QR-код на чеке',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
