import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tally_up/src/features/cheque_list/presentation/pages/AddObjectScreen.dart';

class ChequeWidget extends StatefulWidget {
  const ChequeWidget({super.key});

  @override
  State<ChequeWidget> createState() => _ChequeWidgetState();
}

class _ChequeWidgetState extends State<ChequeWidget> {
  final List<Product> products = [
    Product(1, "Чоколадка Милка", 1, 54, 54),
    Product(2, "CoolCola", 1, 10, 10),
    Product(3, "Негр", 1, 20, 20),
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.only(top: 160),
        width: 370,
        height: 500,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 48,
              offset: Offset(4, 8),
            ),
          ],
        ),
        child: Column(children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 5),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Text('Кассовый чек №0228',
                          style: theme.textTheme.headlineMedium),
                      Text(
                          textAlign: TextAlign.center,
                          '31.10.2023 18:27\n'
                          'http://www.ozon.ru/\n'
                          'Интернет решения, ООО\n'
                          'ИНН 7704217370\n'
                          'Вид налогооблажения: ОСН\n'
                          'Приход',
                          style: theme.textTheme.displayLarge
                              ?.copyWith(fontSize: 13))
                    ],
                  ))),
          const Divider(
            height: 1.0,
            color: Colors.grey,
            indent: 20.0,
            endIndent: 20.0,
            // dashPattern: [5, 3],
          ),
          Container(
              height: 18,
              width: 355,
              child: Row(
                children: [
                  SizedBox(width: 7),
                  Text(
                    '№',
                    style: theme.textTheme.headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Название',
                    style: theme.textTheme.headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(width: 45),
                  Text(
                    'Цена',
                    style: theme.textTheme.headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(width: 40),
                  Text(
                    'Кол-во',
                    style: theme.textTheme.headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(width: 30),
                  Text(
                    'Сумма',
                    style: theme.textTheme.headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              )),
          Expanded(
            child: Container(
                child: ListView.builder(
              itemCount: products.length,
              itemExtent: 40,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Row(
                    children: [
                      Container(
                        width: 20,
                        child: Text(
                          textAlign: TextAlign.left,
                          '${products[index].id}.',
                          style: theme.textTheme.headlineMedium
                              ?.copyWith(fontSize: 10),
                        ),
                      ),
                      Container(
                        width: 120,
                        child: Text(
                          '${products[index].name}',
                          style: theme.textTheme.headlineMedium
                              ?.copyWith(fontSize: 10),
                        ),
                      ),
                      Container(
                        width: 30,
                        child: Text(
                          textAlign: TextAlign.center,
                          '${products[index].price}',
                          style: theme.textTheme.headlineMedium
                              ?.copyWith(fontSize: 10),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Container(
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.white70,
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
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                                width: 35,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Color(0xFF0079FF),
                                    size: 18,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (products[index].quantity > 0) {
                                        products[index].quantity--;
                                        products[index].updatePrice();
                                      }
                                    });
                                  },
                                )),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                products[index].quantity.toString(),
                                style: theme.textTheme.headlineMedium?.copyWith(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 35,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.add,
                                  color: Color(0xFF0079FF),
                                  size: 18,
                                ),
                                onPressed: () {
                                  setState(() {
                                    products[index].quantity++;
                                    products[index].updatePrice();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  trailing: Container(
                    width: 30,
                    child: Text(
                      textAlign: TextAlign.center,
                      '${products[index].finalPrice}',
                      style: theme.textTheme.headlineMedium
                          ?.copyWith(fontSize: 10),
                    ),
                  ),
                );
              },
            )),
          ),
          const Divider(
            height: 1.0,
            color: Colors.grey,
            indent: 20.0,
            endIndent: 20.0,
            // dashPattern: [5, 3],
          ),
          Container(
              margin: EdgeInsets.only(left: 10, bottom: 130, top: 5),
              child: Row(
                children: [
                  Text(
                    'ИТОГО:',
                    style: theme.textTheme.headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  SizedBox(
                    width: 195,
                  ),
                  Text(
                    '450.90',
                    style: theme.textTheme.headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold, fontSize: 22),
                  )
                ],
              )),
          const Divider(
            height: 1.0,
            color: Colors.grey,
            indent: 20.0,
            endIndent: 20.0,
            // dashPattern: [5, 3],
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            width: 350,
            child: Text(
                textAlign: TextAlign.left,
                'ВИД НАЛОГО ОБЛАЖЕНИЯ: ОСН\n'
                'РЕГ. НОМЕР ККТ: 0000889102008798 \n'
                'ЗАВОД. №: '
                'ФН: №8710000101239416 \n'
                'ФД: №1179'
                'ФПД: #4176157690 \n'
                'Сайт ФНС:www.nalog.ru',
                style: theme.textTheme.headlineMedium?.copyWith(fontSize: 11)),
          )
        ]),
      ),
    );
  }
}
