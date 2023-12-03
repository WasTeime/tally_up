import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tally_up/src/features/auth/presentation/pages/qrscaneroverlay.dart';

import '../../../../core/theme.dart';
import 'QRResultScreen.dart';

const BGColor = Colors.white70;

class QRScaner extends StatefulWidget {
  const QRScaner({super.key});

  @override
  State<QRScaner> createState() => _QRScanerState();
}

class _QRScanerState extends State<QRScaner> {
  bool isScanComplited = false;
  bool isFlashOn = false;
  bool isFrontCamere = false;
  final MobileScannerController controller = MobileScannerController();

  void closeScreen() {
    isScanComplited = false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = GetIt.I<AppTheme>().currentTheme;
    return Scaffold(
      backgroundColor: BGColor,
      drawer: const Drawer(),
      body: Container(
        width: double.infinity,
        child: Stack(
          children: [
            MobileScanner(
              controller: controller,
              onDetect: (BarcodeCapture capture) {
                final List<Barcode> barcodes = capture.barcodes;
                Barcode barcode = barcodes.first;
                if (!isScanComplited) {
                  String code = barcode.rawValue ?? '---';
                  isScanComplited = true;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QRResult(
                        closeScreen: closeScreen,
                        code: code,
                      ),
                    ),
                  );
                }
              },
            ),
            QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5)),
            Positioned(
              top: 30,
              right: 20,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(
                      context); // Navigate back to the previous screen
                },
                icon: const Icon(Icons.close, color: Colors.white, size: 40),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 550),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isFlashOn = !isFlashOn;
                            });
                            controller.toggleTorch();
                          },
                          icon: Icon(
                            Icons.flash_on,
                            color: isFlashOn ? Colors.blue : Colors.white,
                            size: 30,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isFrontCamere = !isFrontCamere;
                            });
                            controller.switchCamera();
                          },
                          icon: Icon(
                            Icons.camera_front,
                            color: isFrontCamere ? Colors.blue : Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    Card(
                      margin: const EdgeInsets.only(right: 30, left: 30),
                      elevation: 4, // Add elevation for a shadow effect
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const SizedBox(
                          width: 450,
                          height: 80,
                          child: Align(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Align content at the top
                              children: [
                                Icon(
                                  Icons.qr_code,
                                  size: 40,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Flexible(
                                  child: Text(
                                    'Наведите камеру на QR-код на чеке, чтобы отсканировать его',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
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
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "вручную",
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Rubik',
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                                decorationThickness: 1,
                                fontWeight: FontWeight.w900),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
