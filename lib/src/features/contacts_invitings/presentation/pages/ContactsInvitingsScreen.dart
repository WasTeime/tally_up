import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tally_up/src/features/auth/data/repository/authController.dart';
import 'package:tally_up/src/features/contacts_invitings/presentation/pages/ContactsScreen.dart';
import 'package:tally_up/src/features/contacts_invitings/presentation/pages/InvitingsFriendsScreen.dart';

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

  Widget title() {
    final theme = Theme.of(context);
    return Text("Друзья и приглашения",
        style: theme.textTheme.headlineMedium
            ?.copyWith(fontSize: 20, fontWeight: FontWeight.bold));
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBarWidget: AppBarWidget(
        titleWidget: title(),
      ),
      subAppBarWidget: HomeTabBarForFrendsWidget(tabController: _tabController),
      contentWidget: HomeTabBarForFrendsScreens(tabController: _tabController),
    );
  }
}
