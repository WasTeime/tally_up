import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tally_up/src/core/widgets/ColumnGapWidget.dart';
import 'package:tally_up/src/core/widgets/LoadingWidget.dart';
import 'package:tally_up/src/features/group/presentation/bloc/group/group_bloc.dart';
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
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () => context.go('/'),
              ),
              title: SizedBox(
                width: 180,
                child: Card(
                  color: Colors.white,
                  elevation: 5,
                  child: (state is GroupLoaded)
                      ? Column(
                          children: [
                            Text(state.groupDetails['groupName']),
                            Text(
                                '${state.groupDetails['participants'].length} участников'),
                          ],
                        )
                      : null,
                ),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: (state is GroupLoaded)
                  ? state.groupDetails['events'].length > 0
                      ? ListView.builder(
                          itemCount: state.groupDetails['events'].length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                EventsListItemWidget(
                                  index,
                                  Icons.abc,
                                  state.groupDetails['events'][index]
                                      ['eventName'],
                                  "djfkalsjfkl",
                                ),
                                const ColumnGapWidget()
                              ],
                            );
                          },
                        )
                      : const Center(
                          child: Text('У вас пока нет мероприятий'),
                        )
                  : const LoadingWidget(),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                context.go('/createEvent');
              },
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        },
      ),
    );
  }
}
