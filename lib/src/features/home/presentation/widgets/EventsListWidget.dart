import 'package:flutter/material.dart';
import 'package:tally_up/src/core/widgets/view.dart';
import 'package:tally_up/src/features/home/presentation/widgets/EventsListItemWidget.dart';

class EventsListWidget extends StatefulWidget {
  const EventsListWidget({super.key});

  @override
  State<EventsListWidget> createState() => _EventsListWidgetState();
}

class _EventsListWidgetState extends State<EventsListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Column(
          children: [
            EventsListItemWidget(
              index,
              Icons.car_repair,
              'item$index',
              '03.10.2023',
            ),
            const ColumnGapWidget(
              height: 10,
            ),
          ],
        );
      },
    );
  }
}
