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
  final Size preferredSize = const Size.fromHeight(
    kToolbarHeight + 20,
  ); //todo! надо поменять чтобы высота в зависимости от контента считалась

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
    this.titleWidget,
    required this.enableArchive,
    this.enableEditButton,
  });

  const AppBarWidget.withAcceptButton({
    super.key,
    required this.enableAcceptButton,
    this.enableBackButton,
    this.titleWidget,
    this.enableArchive,
    this.enableEditButton,
  });

  const AppBarWidget.withEditButton({
    super.key,
    required this.enableEditButton,
    this.enableBackButton,
    this.titleWidget,
    this.enableAcceptButton,
    this.enableArchive,
  });

  List<Widget>? actionsAppBar({required double iconSize}) {
    if (enableAcceptButton != null) {
      return [
        IconButton(
          onPressed: () => enableAcceptButton!(),
          icon: Icon(
            Icons.check,
            size: iconSize,
            color: Colors.blue,
          ),
        )
      ];
    } else if (enableArchive != null) {
      return [
        IconButton(
          onPressed: () => enableArchive!(),
          icon: Icon(
            Icons.archive,
            size: iconSize,
            color: Colors.blue,
          ),
        )
      ];
    } else if (enableEditButton != null) {
      return [
        IconButton(
          onPressed: () => enableEditButton!(),
          icon: const Icon(
            Icons.edit,
            size: 30,
            color: Colors.blue,
          ),
        )
      ];
    }
    return [];
  }
}

class _AppBarWidgetState extends State<AppBarWidget> {
  double iconSize = 35; //кроме иконки редактирования

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFFF1F7FF),
      toolbarHeight: const Size.fromHeight(kToolbarHeight + 20)
          .height, //todo надо поменять чтобы высота в зависимости от контента считалась
      title: widget.titleWidget,
      actions: widget.actionsAppBar(iconSize: iconSize),
      leading: widget.enableBackButton != null
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              iconSize: 35,
              onPressed: widget.enableBackButton,
              color: Colors.blue,
            )
          : null,
      centerTitle: true,
    );
  }
}
