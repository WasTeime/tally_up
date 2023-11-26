import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tally_up/src/core/widgets/TextButtonWidget.dart';

class FinalPriceWidget extends StatelessWidget {
  const FinalPriceWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                    Text('Мой долг:',
                        style: theme.textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 22)),
                    Text('100.00 РУБ',
                        style: theme.textTheme.headlineLarge
                            ?.copyWith(fontSize: 22))
                  ],
                ),
              ),
              Container(
                // margin: EdgeInsets.only(top: 200),
                child: TextButtonWidget(() => {}, "Перевести"),
              ),
            ],
          )),
    );
  }
}
