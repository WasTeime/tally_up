import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventsListItemWidget extends StatelessWidget {
  final IconData icon;
  final String eventName;
  final String date;
  final DocumentReference eventRef;

  const EventsListItemWidget(
      this.eventRef, this.icon, this.eventName, this.date,
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
      onTap: () => context.go('/event', extra: eventRef),
      child: Card(
        elevation: 10,
        shadowColor: Colors.black54,
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(children: [
            cardIcon(),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
