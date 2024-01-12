import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/layouts/mainLayout.dart';
import '../../../../core/widgets/view.dart';
import '../widgets/TabBarForFrends.dart';

class ContactsInvitingsScreen extends StatefulWidget {
  const ContactsInvitingsScreen({super.key});

  @override
  State<ContactsInvitingsScreen> createState() =>
      _ContactsInvitingsScreenState();
}

class _ContactsInvitingsScreenState extends State<ContactsInvitingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MainLayout(
      appBarWidget: AppBarWidget(
        titleWidget: Text(
          "Контакты и приглашения",
          style: theme.textTheme.headlineMedium
              ?.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        enableBackButton: context.canPop() ? () => context.pop() : null,
      ),
      subAppBarWidget: HomeTabBarForFrendsWidget(tabController: _tabController),
      contentWidget: HomeTabBarForFrendsScreens(tabController: _tabController),
    );
  }
}
