import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tally_up/src/core/widgets/view.dart';
import 'package:tally_up/src/features/home/presentation/widgets/view.dart';

class EventsListWidget extends StatefulWidget {
  final List<Map<String, dynamic>> data;

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
          var eventData = widget.data[index]['data'];
          var eventRef = widget.data[index]['event_ref'];
          return Column(
            children: [
              EventsListItemWidget(
                eventRef,
                Icons.paragliding,
                eventData['name'].toString(),
                DateFormat("dd.MM.yyyy").format(
                  (eventData['created_at'] as Timestamp).toDate(),
                ),
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
