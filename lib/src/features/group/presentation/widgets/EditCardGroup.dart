import 'package:flutter/material.dart';

class EditCardGroup extends StatefulWidget {
  final String name;
  final String people;
  const EditCardGroup({required this.name, required this.people});

  @override
  _EditCardEventState createState() => _EditCardEventState();
}

class _EditCardEventState extends State<EditCardGroup> {
  late TextEditingController titleController;
  late TextEditingController subtitleController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.name);
    subtitleController = TextEditingController(text: widget.people);
  }

  @override
  void dispose() {
    titleController.dispose();
    subtitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 60),
      child: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              title: EditableText(
                controller: titleController,
                style: theme.textTheme.titleMedium!.copyWith(
                  fontSize: 17,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.bold,
                ),
                backgroundCursorColor: Colors.black,
                cursorColor: Colors.black,
                selectionColor: Colors.black,
                autocorrect: true,
                maxLines: null,
                focusNode: FocusNode(),
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  EditableText(
                    controller: subtitleController,
                    style: theme.textTheme.titleMedium!.copyWith(
                      fontSize: 12,
                      fontFamily: 'Rubik',
                    ),
                    backgroundCursorColor: Colors.black,
                    cursorColor: Colors.black,
                    selectionColor: Colors.black,
                    autocorrect: true,
                    maxLines: null,
                    focusNode: FocusNode(),
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
