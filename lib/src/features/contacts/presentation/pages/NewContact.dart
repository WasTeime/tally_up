import 'package:flutter/material.dart';
import 'package:tally_up/src/core/widgets/FormFriendWigdet.dart';
import 'package:tally_up/src/core/widgets/NamePage.dart';
import 'package:tally_up/src/core/widgets/NavigIconsBar.dart';
import 'package:tally_up/src/core/widgets/PhotoProfile.dart';

class NewContact extends StatefulWidget {
  const NewContact({super.key});

  @override
  State<NewContact> createState() => _NewContactState();
}

class _NewContactState extends State<NewContact> {
  @override
  Widget _textForm() {
    return Container(
        margin: EdgeInsets.only(top: 340),
        child: Column(
          children: [
            FormFriendWidget(text: 'Имя'),
            SizedBox(
              height: 15,
            ),
            FormFriendWidget(text: 'Телефон'),
          ],
        ));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        NamePage(text: 'Новый контакт'),
        PhotoProfile(),
        NavigIconsBar(),
        _textForm()
      ]),
    );
  }
}
