import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tally_up/src/core/layouts/mainLayout.dart';
import 'package:tally_up/src/core/widgets/view.dart';
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
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final appBarWidget = AppBarWidget.searchAndArchive(
        titleWidget: const SearchBarWidget(),
        enableArchive: () {
          print('press on archive');
        });
    return MainLayout(
        appBarWidget: appBarWidget,
        subAppBarWidget: HomeTabBarWidget(tabController: _tabController),
        contentWidget: HomeTabBarScreens(tabController: _tabController),
        underContentButtonWidget: ElevatedButton(
          onPressed: () => context.go('/createGroup'),
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(7),
            backgroundColor: const Color(0xFF0079FF),
            foregroundColor: Colors.blue,
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 45,
          ),
        ));
  }
}
