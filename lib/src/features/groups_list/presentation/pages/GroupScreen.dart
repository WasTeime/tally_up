import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tally_up/src/core/theme.dart';
import 'package:tally_up/src/features/auth/presentation/bloc/groupe/groupe_bloc.dart';

import '../../../../core/widgets/view.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  final _groupeListBlock = GroupBloc();

  @override
  void initState() {
    // _groupeListBlock.add();
    super.initState();
  }

  @override
  Widget _backGround() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 40, left: 30, right: 30),
              height: 75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SearchBarWidget(),
                  const SizedBox(width: 25),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.archive,
                      size: 30,
                      color: Colors.blue,
                    ),
                  ), // Пробел между текстовым полем и иконкой
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _groupe() {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 130, bottom: 60),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, i) {
          return InkWell(
            // Добавленный GestureDetector
            onTap: () {
              // Действие при нажатии
              print('Вы нажали на карточку $i');
            },
            child: Card(
              margin: const EdgeInsets.only(bottom: 20),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox(
                width: 300,
                height: 100,
                child: Align(
                  child: ListTile(
                    title: Text(
                      'Группа $i',
                      style: const TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    trailing: const Icon(Icons.info),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget build(BuildContext context) {
    return BlocProvider<GroupBloc>(
      create: (context) => GroupBloc()..add(LoadGroupList()),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 218, 235, 255),
        body: BlocBuilder<GroupBloc, GroupState>(
          builder: (context, state) {
            if (state is GroupLoaded) {
              return Stack(
                children: [
                  _backGround(),
                  GroupeAndEvents(),
                  _groupe(),
                  NavigIconsBar(),
                  ButtonAdd(),
                ],
              );
            } else if (state is GroupLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GroupLoadingFailure) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Произошла ошибка: ${state.error}'),
                  ElevatedButton(
                    onPressed: () {
                      context.read<GroupBloc>().add(LoadGroupList());
                    },
                    child: const Text('Перезапустить'),
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
