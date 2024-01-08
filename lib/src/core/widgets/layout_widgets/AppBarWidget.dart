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

  List<Widget>? get actionsAppBar {
    if (enableAcceptButton != null) {
      return [
        IconButton(
            onPressed: () => enableAcceptButton!(),
            icon: const Icon(Icons.check))
      ];
    }
    if (enableArchive != null) {
      return [
        IconButton(
          onPressed: () => enableArchive!(),
          icon: const Icon(Icons.archive),
        )
      ];
    }
    if (enableEditButton != null) {
      return [
        IconButton(
          onPressed: () => enableEditButton!(),
          icon: const Icon(Icons.edit),
        )
      ];
    }
    return [];
  }
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: const Size.fromHeight(kToolbarHeight + 20)
          .height, //todo! надо поменять чтобы высота в зависимости от контента считалась
      title: widget.titleWidget,
      actions: widget.actionsAppBar,
      leading: widget.enableBackButton != null
          ? BackButton(
              onPressed: widget.enableBackButton,
            )
          : null,
      centerTitle: true,
    );
  }
}
