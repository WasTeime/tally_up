import 'package:flutter/material.dart';
import 'package:tally_up/src/core/widgets/SearchWidget.dart';

//todo доделать, приделать функционал
class AppBarWidget extends StatelessWidget {
  //можно поменять эти поля на типо такого
  //final Function enableAcceptButton; с помощью callback или типо того можно сделать
  final bool enableSearch;
  final bool enableArchive;
  final bool enableBackButton;
  final bool enableAcceptButton;
  final bool enableEditButton;

  const AppBarWidget({
    super.key,
    required this.enableSearch,
    required this.enableArchive,
    required this.enableBackButton,
    required this.enableAcceptButton,
    required this.enableEditButton,
  });

  const AppBarWidget.homePage({
    super.key,
    this.enableArchive = true,
    this.enableSearch = true,
    this.enableAcceptButton = false,
    this.enableBackButton = false,
    this.enableEditButton = false,
  });

  const AppBarWidget.create({
    super.key,
    this.enableArchive = false,
    this.enableSearch = false,
    this.enableAcceptButton = true,
    this.enableBackButton = true,
    this.enableEditButton = false,
  });

  List<Widget>? get actionsAppBar {
    if (enableAcceptButton) {
      return [IconButton(onPressed: () {}, icon: const Icon(Icons.check))];
    }
    if (enableArchive) {
      return [IconButton(onPressed: () {}, icon: const Icon(Icons.archive))];
    }
    if (enableEditButton) {
      return [IconButton(onPressed: () {}, icon: const Icon(Icons.edit))];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: enableBackButton ? const BackButton() : null,
      title: enableSearch
          ? SearchWidget(
              textController: TextEditingController(),
            )
          : null,
      actions: actionsAppBar,
    );
  }
}
