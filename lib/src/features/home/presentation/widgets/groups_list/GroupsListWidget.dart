import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tally_up/src/core/widgets/view.dart';
import 'package:tally_up/src/features/home/presentation/bloc/groups/groups_bloc.dart';
import 'package:tally_up/src/features/home/presentation/widgets/view.dart';

class GroupsListWidget extends StatefulWidget {
  const GroupsListWidget({super.key});

  @override
  State<GroupsListWidget> createState() => _GroupsListWidgetState();
}

class _GroupsListWidgetState extends State<GroupsListWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<GroupsBloc>(
      create: (context) => GroupsBloc(),
      child: BlocBuilder<GroupsBloc, GroupsState>(
        builder: (context, state) {
          if (state is GroupsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is GroupsLoaded) {
            if (state.groups.isEmpty) {
              return const Center(child: Text('У вас пока нет групп'));
            }
            return ListView.builder(
              itemCount: state.groups.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        context.go(
                          '/group',
                          extra: state.groups[index]['group_ref'],
                        );
                      },
                      child: GroupsListItemWidget(
                        List<Widget>.generate(
                          state.groups[index]['participants'].length,
                          (index) => Icon(Icons.circle),
                        ),
                        state.groups[index]['groupName'],
                        '03.10.2023',
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
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
