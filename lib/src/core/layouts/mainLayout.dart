import 'package:flutter/material.dart';
import 'package:tally_up/src/core/widgets/view.dart';

class MainLayout extends StatefulWidget {
  final PreferredSizeWidget? appBarWidget;
  final Widget? subAppBarWidget;
  final Widget? contentWidget;
  final Widget? underContentButtonWidget;

  final bool enableContentPaddings;

  const MainLayout({
    super.key,
    required this.appBarWidget,
    this.subAppBarWidget,
    required this.contentWidget,
    this.underContentButtonWidget,
    this.enableContentPaddings = true,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout>
    with SingleTickerProviderStateMixin {
  //var contentPadding = const EdgeInsets.symmetric(horizontal: 10, vertical: 10);

  Widget get subAppBarWithContent {
    if (widget.subAppBarWidget != null && widget.contentWidget != null) {
      return Column(
        children: [
          widget.subAppBarWidget!,
          widget.contentWidget!
          // widget.enableContentPaddings
          //     ? Padding(
          //         padding: contentPadding,
          //         child: widget.contentWidget!,
          //       )
          //     : widget.contentWidget!,
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
