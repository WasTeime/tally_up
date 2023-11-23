import 'package:flutter/material.dart';
import 'package:tally_up/src/core/widgets/view.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SearchBarWidget(),
                  SizedBox(width: 25),
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

  Widget _events() {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 130, bottom: 160),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, i) {
          return Card(
            margin: const EdgeInsets.only(bottom: 20),
            color: Color(0xFF0079FF),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: SizedBox(
              width: 300,
              height: 100,
              child: Align(
                alignment: Alignment.center,
                child: ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    padding: EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/events1.png",
                          ),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ),
                  title: Text('Мероприятие №$i',
                      style: theme.textTheme.headlineMedium
                          ?.copyWith(color: Colors.white)),
                  subtitle: Text('11.12.2003',
                      style: theme.textTheme.headlineMedium
                          ?.copyWith(fontSize: 13, color: Colors.white)),
                  trailing: Icon(Icons.info),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 218, 235, 255),
        body: Stack(
          children: [
            GroupeAndEvents(),
            _backGround(),
            _events(),
            ButtonAdd(),
            NavigIconsBar()
          ],
        ));
  }
}
