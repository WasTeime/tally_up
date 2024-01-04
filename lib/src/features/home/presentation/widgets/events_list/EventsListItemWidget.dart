import 'package:flutter/material.dart';

class EventsListItemWidget extends StatelessWidget {
  final IconData icon;
  final String eventName;
  final String date;
  final int index;

  const EventsListItemWidget(this.index, this.icon, this.eventName, this.date,
      {super.key});

  @override
  Widget build(BuildContext context) {
    Widget cardIcon() {
      return Container(
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(17))),
        child: Icon(
          icon,
          size: 40,
          color: Colors.black,
        ),
      );
    }

    return InkWell(
      onTap: () {
        print(index);
      },
      child: Card(
        elevation: 10,
        shadowColor: Colors.black54,
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(children: [
            cardIcon(),
            const SizedBox(
              width: 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventName,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 22),
                ),
                Text(date,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 17))
              ],
            )
          ]),
        ),
      ),
    );
  }
}
