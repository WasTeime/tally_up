import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FinalPriceWidget extends StatelessWidget {
  final String word;
  final double price;
  final String button;
  const FinalPriceWidget(
      {super.key,
      required this.word,
      required this.price,
      required this.button});

  @override
  Widget build(BuildContext context) {
    Widget _TextButtonCheque() {
      final theme = Theme.of(context);
      return TextButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xFF0078FE)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            button,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineLarge,
          ),
        ),
      );
    }

    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          height: 70,
          width: 350,
          margin: EdgeInsets.only(bottom: 80),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 10,
                offset: Offset(4, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 180,
                margin: EdgeInsets.only(left: 15, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(word,
                        style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 22)),
                    Text('${price} РУБ',
                        style: theme.textTheme.headlineMedium
                            ?.copyWith(fontSize: 22))
                  ],
                ),
              ),
              Container(
                child: _TextButtonCheque(),
              ),
            ],
          )),
    );
  }
}
