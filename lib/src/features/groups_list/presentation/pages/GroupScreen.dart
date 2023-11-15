import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tally_up/src/core/theme.dart';

import '../../../../core/widgets/view.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
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
              child: const Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Выравнивание элементов по горизонтали
                children: [
                  SearchBarWidget(),
                  SizedBox(width: 25), // Пробел между текстовым полем и иконкой
                  Icon(
                    Icons.archive,
                    size: 30,
                    color: Colors.blue,
                  ),
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
      padding:
          const EdgeInsets.only(left: 30, right: 30, top: 130, bottom: 160),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, i) {
          return Card(
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
                        ), // Иконка "подробнее"
                      ),
                      trailing: const Icon(Icons.info), // Иконка "подробнее"
                    ),
                  )));
        },
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 218, 235, 255),
      body: Stack(
        children: [
          _backGround(),
          GroupeAndEvents(),
          _groupe(),
          NavigIconsBar(),
          ButtonAdd(),
        ],
      ),
    );
  }
}
