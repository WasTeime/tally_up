import 'package:flutter/material.dart';

class EditCardEvent extends StatefulWidget {
  final String name;
  final String people;
  const EditCardEvent({required this.name, required this.people});

  @override
  _EditCardEventState createState() => _EditCardEventState();
}

class _EditCardEventState extends State<EditCardEvent> {
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
              leading: Container(
                width: 40,
                height: 40,
                padding: EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 255, 255, 255),
                      blurRadius: 48,
                      offset: Offset(4, 8),
                    ),
                  ],
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/events1.png"),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
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
                textAlign: TextAlign.start,
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
                    textAlign: TextAlign.start,
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
