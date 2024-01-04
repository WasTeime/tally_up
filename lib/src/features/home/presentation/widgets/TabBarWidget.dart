import 'package:flutter/material.dart';
import 'package:tally_up/src/features/home/presentation/widgets/view.dart';

class HomeTabBarWidget extends StatelessWidget {
  final TabController _tabController;

  const HomeTabBarWidget({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  //ячейки меню (Группы|Мероприятия)
  @override
  Widget build(BuildContext context) {
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
}

class HomeTabBarScreens extends StatelessWidget {
  final TabController _tabController;

  const HomeTabBarScreens({
    super.key,
    required tabController,
  }) : _tabController = tabController;

  //экраны, отображающиеся по нажатию на ячейку меню
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: GroupsListWidget(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: EventsListWidget(
              data: [],
            ),
          ),
        ],
      ),
    );
  }
}
