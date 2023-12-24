import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tally_up/src/core/theme.dart';

class CustomCardList extends StatefulWidget {
  @override
  _CustomCardListState createState() => _CustomCardListState();
}

class _CustomCardListState extends State<CustomCardList> {
  List<String> cardTitles = ['Card 1', 'Card 2', 'Card 3'];
  List<String> cardData = ['00.00.00', '10.10.10', '20.20.20'];

  @override
  Widget build(BuildContext context) {
    final theme = GetIt.I<AppTheme>().currentTheme;
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: SizedBox(
        height: 530,
        child: ListView.builder(
          itemCount: cardTitles.length,
          itemBuilder: (context, index) {
            return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
                child: Stack(children: [
                  SizedBox(
                    height: 90,
                    child: Card(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: ListTile(
                          leading: Container(
                            width: 45,
                            height: 45,
                            padding: EdgeInsets.all(9),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  blurRadius: 48,
                                  offset: Offset(4, 8),
                                ),
                              ],
                            ),
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/events1.png"),
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            cardTitles[index],
                            style: theme.textTheme.headline6!.copyWith(
                              fontSize:
                                  22.0, // преобразуем значение в тип double
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            cardData[index],
                            style: theme.textTheme.headline6!.copyWith(
                              fontSize:
                                  14.0, // преобразуем значение в тип double
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.more_vert,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        // Действие при нажатии
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.close,
                            color: Colors.blue,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]));
          },
        ),
      ),
    );
  }
}
