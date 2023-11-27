import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tally_up/src/core/widgets/NameEvent.dart';

import '../../../../core/widgets/view.dart';
import '../../../auth/presentation/bloc/sign_in/sign_in_bloc.dart';

class ChequeListInEvent extends StatefulWidget {
  const ChequeListInEvent({super.key});

  @override
  State<ChequeListInEvent> createState() => _ChequeListInEventState();
}

class _ChequeListInEventState extends State<ChequeListInEvent> {
  String? get code => null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget _dateListCheque() {
      return Center(
        child: Container(
          margin: const EdgeInsets.only(bottom: 530),
          child: Text(
            DateFormat('dd.MM.yyyy').format(DateTime(2002, 10, 10)),
            style: theme.textTheme.headlineSmall?.copyWith(
              fontSize: 24, // Размер шрифта
              fontWeight: FontWeight.bold, // Жирный шрифт
            ),
          ),
        ),
      );
    }

    Widget _TextButtonCheque() {
      return TextButton(
        onPressed: () {
          // Действие при нажатии кнопки
        },
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xFF0078FE)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          // Указываем минимальный размер кнопки
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Разделить \nпоровну',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Raleway-medium',
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.02,
            ),
          ),
        ),
      );
    }

    Widget _lastSum() {
      return Container(
        margin: const EdgeInsets.only(top: 700, left: 20, right: 20),
        child: Card(
          child: ListTile(
              title: const Text('Итого \n2000 Руб'),
              trailing: _TextButtonCheque()),
        ),
      );
    }

    Widget _chequeList() {
      return Container(
        margin: const EdgeInsets.only(top: 150),
        child: SizedBox(
          height: 530,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  childAspectRatio: 3 / 2,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  maxCrossAxisExtent: 200),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    print("Card Clicked");
                  },
                  child: Container(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage('assets/images/cheque.png'),
                                  width: 40,
                                  height: 40,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Номер чека $index'), // Номер чека
                                const Text('Сумма чека'), // Сумма чека в рублях
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 218, 235, 255),
      body: Stack(
        children: [
          const NameEvent(name: 'Kjk', people: 'ео'),
          _dateListCheque(),
          _chequeList(),
          _lastSum(),
          NavigIconsBar(),
        ],
      ),
    );
  }
}
