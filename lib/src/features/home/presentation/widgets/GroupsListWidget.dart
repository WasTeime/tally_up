import 'package:flutter/material.dart';
import 'package:tally_up/src/core/widgets/view.dart';
import 'package:tally_up/src/features/home/presentation/widgets/GroupsListItemWidget.dart';

class GroupsListWidget extends StatefulWidget {
  const GroupsListWidget({super.key});

  @override
  State<GroupsListWidget> createState() => _GroupsListWidgetState();
}

class _GroupsListWidgetState extends State<GroupsListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Column(
          children: [
            GroupsListItemWidget(
              index,
              List<Widget>.generate(5, (index) => Icon(Icons.circle)),
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
