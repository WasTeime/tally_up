import 'package:flutter/material.dart';

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
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Выравнивание элементов по горизонтали
                children: [
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        fillColor: Colors.white,
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(207, 203, 203, 0.989),
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 3,
                          ),
                        ),
                        hintStyle: const TextStyle(color: Color(0xFFD3E8FF)),
                      ),
                    ),
                  ),
                  const SizedBox(
                      width: 25), // Пробел между текстовым полем и иконкой
                  const Icon(
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

  Widget _buttonPlus(void func()) {
    return Container(
      margin: const EdgeInsets.only(top: 650),
      child: Center(
          child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(10),
          backgroundColor: const Color(0xFF0079FF), // <-- Button color
          foregroundColor: Colors.blue, // <-- Splash color
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 60,
        ),
      )),
    );
  }

  Widget _groupeEvents() {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 90),
      child: Row(
        children: [
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              // Обработка нажатия для "Группы"
            },
            child: const Text(
              'Группы',
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 18,
                color: Colors.black,
                decoration:
                    TextDecoration.none, // Подчеркивания нет по умолчанию
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              // Обработка нажатия для "Мероприятия"
            },
            child: const Text(
              'Мероприятия',
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 18,
                color: Colors.black,
                decoration:
                    TextDecoration.none, // Подчеркивания нет по умолчанию
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _groupe() {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 130, bottom: 160),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, i) {
          return Container(
            height: 90,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white, // Белый задний фон
              borderRadius: BorderRadius.circular(10), // Круглые края
            ),
            child: ListTile(
              title: Text(
                'Группа $i',
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 18,
                  color: Colors.black,
                ), // Иконка "подробнее"
              ),
              trailing: Icon(Icons.info), // Иконка "подробнее"
            ),
          );
        },
      ),
    );
  }

  Widget _NovigIcons() {
    return Container(
      margin: const EdgeInsets.only(left: 13, right: 13, top: 810),
      padding: const EdgeInsets.only(left: 15, right: 20),
      width: 680,
      height: 60,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.shopping_cart,
            size: 30,
          ),
          Icon(
            Icons.home_rounded,
            size: 30,
          ),
          Icon(
            Icons.accessible_forward_sharp,
            size: 30,
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf0f7ff),
      body: Stack(
        children: [
          _backGround(),
          _groupeEvents(),
          _groupe(),
          _NovigIcons(),
          _buttonPlus(() {})
        ],
      ),
    );
  }
}
