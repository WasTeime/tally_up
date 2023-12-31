import 'package:flutter/material.dart';
import 'package:tally_up/src/features/contacts_invitings/presentation/pages/InvitingsFriendsScreen.dart';

import '../pages/ContactsScreen.dart';

class HomeTabBarForFrendsWidget extends StatelessWidget {
  final TabController _tabController;

  const HomeTabBarForFrendsWidget({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabAlignment: TabAlignment.start,
      controller: _tabController,
      isScrollable: true,
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.blue,
      tabs: const [
        Tab(text: "Друзья"),
        Tab(text: "Приглашения"),
      ],
    );
  }
}

class HomeTabBarForFrendsScreens extends StatelessWidget {
  final TabController _tabController;

  const HomeTabBarForFrendsScreens({
    super.key,
    required tabController,
  }) : _tabController = tabController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: FriendsScreen(),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: InvitingsList(),
          ),
        ],
      ),
    );
  }
}
