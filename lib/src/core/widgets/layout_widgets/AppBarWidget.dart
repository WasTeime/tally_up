import 'package:flutter/material.dart';

//todo доделать, приделать функционал
class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  //можно поменять эти поля на типо такого
  //final Function enableAcceptButton; с помощью callback или типо того можно сделать
  final Widget? titleWidget;
  final VoidCallback? enableArchive;
  final VoidCallback? enableBackButton;
  final VoidCallback? enableAcceptButton;
  final VoidCallback? enableEditButton;

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight +
      20); //todo! надо поменять чтобы высота в зависимости от контента считалась

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  const AppBarWidget({
    super.key,
    this.titleWidget,
    this.enableArchive,
    this.enableBackButton,
    this.enableAcceptButton,
    this.enableEditButton,
  });

  const AppBarWidget.searchAndArchive({
    super.key,
    this.enableAcceptButton,
    this.enableBackButton,
    required this.titleWidget,
    required this.enableArchive,
    this.enableEditButton,
  });

  const AppBarWidget.withAcceptButton({
    super.key,
    required this.enableAcceptButton,
    required this.enableBackButton,
    required this.titleWidget,
    this.enableArchive,
    this.enableEditButton,
  });

  const AppBarWidget.withEditButton({
    super.key,
    required this.enableEditButton,
    required this.enableBackButton,
    required this.titleWidget,
    this.enableAcceptButton,
    this.enableArchive,
  });

  const AppBarWidget.onlyEdit({
    super.key,
    required this.enableEditButton,
    this.enableBackButton,
    this.titleWidget,
    this.enableAcceptButton,
    this.enableArchive,
  });
  List<Widget>? get actionsAppBar {
    List<Widget>? widget = [];
    double iconSize = 35;
    if (enableAcceptButton != null) {
      widget.add(
        IconButton(
          onPressed: () => enableAcceptButton!(),
          icon: Icon(
            Icons.check,
            size: iconSize,
            color: Colors.blue,
          ),
        ),
      );
    } else if (enableArchive != null) {
      widget.add(
        IconButton(
          onPressed: () => enableArchive!(),
          icon: Icon(
            Icons.archive,
            size: iconSize,
            color: Colors.blue,
          ),
        ),
      );
    } else if (enableEditButton != null) {
      widget.add(
        IconButton(
          onPressed: () => enableEditButton!(),
          icon: Icon(
            Icons.edit,
            size: iconSize,
            color: Colors.blue,
          ),
        ),
      );
    }
    return widget;
  }
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF1F7FF),
      toolbarHeight: const Size.fromHeight(kToolbarHeight + 20)
          .height, //todo надо поменять чтобы высота в зависимости от контента считалась
      title: widget.titleWidget,
      actions: widget.actionsAppBar,
      leading: widget.enableBackButton != null
          ? BackButton(
              onPressed: widget.enableBackButton,
              color: Colors.blue,
            )
          : null,
      centerTitle: true,
    );
  }
}
