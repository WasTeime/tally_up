import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tally_up/src/core/layouts/mainLayout.dart';
import 'package:tally_up/src/core/widgets/view.dart';
import 'package:tally_up/src/features/group/presentation/bloc/group/group_bloc.dart';
import 'package:tally_up/src/features/group/presentation/widgets/CardWithNameAndParticipantsWidget.dart';
import 'package:tally_up/src/features/home/presentation/widgets/view.dart';

class GroupScreen extends StatefulWidget {
  final DocumentReference groupRef;

  const GroupScreen({
    super.key,
    required this.groupRef,
  });

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<GroupBloc>(
      create: (context) => GroupBloc(groupRef: widget.groupRef),
      child: BlocBuilder<GroupBloc, GroupState>(
        builder: (context, state) {
          return MainLayout(
            appBarWidget: (state is GroupLoaded)
                ? AppBarWidget.withEditButton(
                    enableEditButton: () => print('press on edit button'),
                    enableBackButton: () => context.go('/'),
                    titleWidget: CardWithNameAndParticipantsWidget.forGroup(
                      titleText: state.groupDetails['groupName'],
                      peopleCount: state.groupDetails['participants'].length,
                    ),
                  )
                : null,
            contentWidget: (state is GroupLoaded)
                ? EventsListWidget(data: state.groupDetails['events'])
                : const LoadingWidget(),
            underContentButtonWidget: FloatingActionButton(
              onPressed: () =>
                  context.go('/createEvent', extra: widget.groupRef),
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
