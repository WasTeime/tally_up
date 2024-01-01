import 'package:flutter/material.dart';
import 'package:tally_up/src/core/widgets/view.dart';

class MainLayout extends StatefulWidget {
  final PreferredSizeWidget? appBarWidget;
  final Widget? subAppBarWidget;
  final Widget? contentWidget;
  final Widget? underContentButtonWidget;

  const MainLayout({
    super.key,
    required this.appBarWidget,
    this.subAppBarWidget,
    required this.contentWidget,
    this.underContentButtonWidget,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout>
    with SingleTickerProviderStateMixin {
  Widget get subAppBarWithContent {
    if (widget.subAppBarWidget != null && widget.contentWidget != null) {
      return Column(
        children: [
          widget.subAppBarWidget!,
          widget.contentWidget!,
        ],
      );
    }
    return widget.contentWidget!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBarWidget,
      body: subAppBarWithContent,
      bottomNavigationBar: const BottomNavigationBarWidget(),
      floatingActionButton: widget.underContentButtonWidget,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
