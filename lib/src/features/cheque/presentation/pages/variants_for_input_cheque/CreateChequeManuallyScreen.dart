import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tally_up/src/core/layouts/mainLayout.dart';
import 'package:tally_up/src/core/widgets/view.dart';
import 'package:tally_up/src/features/cheque/presentation/widgets/EnterChequeManuallyTabBarWidget.dart';

class CreateChequeManuallyScreen extends StatefulWidget {
  const CreateChequeManuallyScreen({super.key});

  @override
  State<CreateChequeManuallyScreen> createState() =>
      _CreateChequeManuallyScreenState();
}

class _CreateChequeManuallyScreenState extends State<CreateChequeManuallyScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBarWidget: AppBarWidget(
        titleWidget: Text(
          "Ввести товары в ручную",
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        enableBackButton: () => context.go('/'),
      ),
      subAppBarWidget: EnterChequeManuallyTabBarWidget(
        tabController: _tabController,
      ),
      contentWidget: EnterChequeManuallyTabBarScreens(
        tabController: _tabController,
      ),
    );
  }
}
