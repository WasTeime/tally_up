import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally_up/src/core/widgets/view.dart';
import 'package:tally_up/src/features/home/presentation/bloc/events/events_bloc.dart';
import 'package:tally_up/src/features/home/presentation/bloc/groups/groups_bloc.dart';
import 'package:tally_up/src/features/home/presentation/widgets/view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  Widget _tabs() {
    return TabBar(
      tabAlignment: TabAlignment.start,
      isScrollable: true,
      controller: _tabController,
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.blue,
      tabs: const [
        Tab(
          text: "Группы",
        ),
        Tab(
          text: "Мероприятия",
        ),
      ],
    );
  }

  Widget _searchAndArchive() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          SearchBarWidget(),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {},
            iconSize: 35,
            icon: const Icon(Icons.archive),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _searchAndArchive(),
            _tabs(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: BlocProvider(
                      create: (context) => GroupsBloc(),
                      child: GroupsListWidget(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: BlocProvider(
                      create: (context) => EventsBloc(),
                      child: EventsListWidget(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(label: "fjd", icon: Icon(Icons.abc)),
          BottomNavigationBarItem(label: "dsas", icon: Icon(Icons.abc))
        ],
      ),
    );
  }
}
