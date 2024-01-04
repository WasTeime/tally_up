import 'package:flutter/material.dart';

class GroupsListItemWidget extends StatelessWidget {
  final List<Widget> participants;
  final String groupName;
  final String date;

  const GroupsListItemWidget(this.participants, this.groupName, this.date,
      {super.key});

  Widget participantsList() {
    return Wrap(
      children: participants,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.black54,
      color: Colors.blue,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(groupName), participantsList()]),
        ),
      ),
    );
  }
}
