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
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(17))),
        child: Icon(
          icon,
          size: 33,
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
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            leading: cardIcon(),
            title:
                Text(eventName, style: Theme.of(context).textTheme.labelLarge),
            subtitle:
                Text(date, style: Theme.of(context).textTheme.headlineLarge),
            trailing: const Icon(
              Icons.more_vert,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
