import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NameEventWidget extends StatelessWidget {
  final String name;
  final String people;
  const NameEventWidget({super.key, required this.name, required this.people});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 30,
              color: Color(0xFF0079FF),
            ),
          ),
          Expanded(
            child: Card(
              margin: const EdgeInsets.only(
                right: 25,
                left: 25,
              ),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: SizedBox(
                  width: 500,
                  height: 65,
                  child: Align(
                    alignment: Alignment.center,
                    child: ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        padding: EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 48,
                              offset: Offset(4, 8),
                            ),
                          ],
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/images/events1.png",
                              ),
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 17,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow
                            .ellipsis, // добавил, чтобы невлезший текст не переносился на следующую стрку, как уходил за стенку контейнера, показываясь точками.
                      ),
                      subtitle: Text(
                        people,
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontSize: 12, fontFamily: 'Rubik'),
                      ),
                    ),
                  )),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.check,
              size: 30,
              color: Color(0xFF0079FF),
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
