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
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SizedBox(
                    height: 90, // Высота карточки
                    child: Card(
                      surfaceTintColor: Colors.white,
                      elevation: 10,
                      shadowColor: Colors.black54,
                      child: Center(
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8.0),
                          title: Text(
                            state.groups[index]['groupName'],
                            style: const TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Wrap(
                            // spacing:
                            //     -10, // Устанавливаем расстояние между иконками
                            children: List<Widget>.generate(
                              state.groups[index]['participants'].length,
                              (index) => const Icon(Icons.circle, size: 24),
                            ),
                          ),
                          trailing: const Icon(
                            Icons.more_vert,
                            color: Colors.blue,
                            size: 30,
                          ),
                          onTap: () {
                            context.push(
                              '/group',
                              extra: state.groups[index]['group_ref'],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
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
