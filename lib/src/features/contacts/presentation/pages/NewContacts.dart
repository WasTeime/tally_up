import 'package:flutter/material.dart';
import 'package:tally_up/src/core/widgets/view.dart';
import 'package:tally_up/src/features/contacts/presentation/widgets/view.dart';
import 'package:tally_up/src/features/profile/presentation/widgets/view.dart';

class NewContact extends StatefulWidget {
  const NewContact({super.key});

  @override
  State<NewContact> createState() => _NewContactState();
}

class _NewContactState extends State<NewContact> {
  @override
  Widget _textForm() {
    return Container(
        margin: const EdgeInsets.only(top: 340),
        child: const Column(
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
        const BottomNavigationBarWidget(),
        ProfilePhoto(photo: 'assets/images/profile.png'),
        _textForm()
      ]),
    );
  }
}
