import 'package:flutter/material.dart';
import 'package:tally_up/src/features/cheque/presentation/widgets/enterManuallyTabBarScreens/EnterChequeManuallyCheque.dart';
import 'package:tally_up/src/features/cheque/presentation/widgets/enterManuallyTabBarScreens/EnterChequeManuallyProducts.dart';

class EnterChequeManuallyTabBarWidget extends StatelessWidget {
  final TabController _tabController;

  const EnterChequeManuallyTabBarWidget({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabAlignment: TabAlignment.center,
      isScrollable: true,
      controller: _tabController,
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.blue,
      tabs: const [
        Tab(
          text: "Продукты",
        ),
        Tab(
          text: "Чек",
        ),
      ],
    );
  }
}

class EnterChequeManuallyTabBarScreens extends StatelessWidget {
  final TabController _tabController;

  const EnterChequeManuallyTabBarScreens({
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
            child: EnterChequeManuallyProducts(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: EnterChequeManuallyCheque(),
          ),
        ],
      ),
    );
  }
}
