import 'package:flutter/material.dart';
import 'package:tally_up/src/core/widgets/view.dart';
import 'package:tally_up/src/features/home/presentation/widgets/view.dart';

class EventsListWidget extends StatefulWidget {
  final List data;

  const EventsListWidget({
    super.key,
    required this.data,
  });

  @override
  State<EventsListWidget> createState() => _EventsListWidgetState();
}

class _EventsListWidgetState extends State<EventsListWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.data.isNotEmpty) {
      return ListView.builder(
        itemCount: widget.data.length,
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
    return const Center(
      child: Text('У вас пока нет мероприятий'),
    );
  }
}
