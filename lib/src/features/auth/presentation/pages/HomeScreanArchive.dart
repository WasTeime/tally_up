import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally_up/src/features/home/presentation/bloc/groups/groups_bloc.dart';

import '../../../../core/widgets/view.dart';
import '../../../home/presentation/bloc/events/events_bloc.dart';
import '../../../home/presentation/widgets/view.dart';

class HomeScreanArchive extends StatefulWidget {
  const HomeScreanArchive({super.key});

  @override
  State<HomeScreanArchive> createState() => _HomeScreanArchiveState();
}

class _HomeScreanArchiveState extends State<HomeScreanArchive>
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

  Widget _searchAndBack() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 30,
              color: Color(0xFF0079FF),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          SearchBarWidget(),
        ],
      ),
    );
  }

  Widget _rowNameArchive() {
    final theme = Theme.of(context);
    return Center(
      child: Text(
        'Архив',
        style: theme.textTheme.headlineMedium
            ?.copyWith(fontSize: 23, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              _searchAndBack(),
              SizedBox(height: 10),
              _rowNameArchive(),
              SizedBox(height: 5),
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
        bottomNavigationBar: BottomNavigationBarAllScreen());
  }
}
