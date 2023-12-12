import 'package:flutter/material.dart';
<<<<<<< HEAD:lib/src/features/contacts/presentation/pages/NewContact.dart
import 'package:tally_up/src/core/widgets/FormFriendWigdet.dart';
import 'package:tally_up/src/core/widgets/NamePage.dart';
import 'package:tally_up/src/core/widgets/PhotoProfile.dart';
import 'package:tally_up/src/core/widgets/view.dart';
=======
import 'package:tally_up/src/core/widgets/NavigIconsBar.dart';
import 'package:tally_up/src/features/contacts/presentation/widgets/view.dart';
import 'package:tally_up/src/features/profile/presentation/widgets/view.dart';
>>>>>>> e75fda969c0448549a529924ceed536e29316b83:lib/src/features/contacts/presentation/pages/NewContacts.dart

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
<<<<<<< HEAD:lib/src/features/contacts/presentation/pages/NewContact.dart
        PhotoProfile(),
        const BottomNavigationBarWidget(),
=======
        ProfilePhoto(photo: 'assets/images/profile.png'),
        NavigIconsBar(),
>>>>>>> e75fda969c0448549a529924ceed536e29316b83:lib/src/features/contacts/presentation/pages/NewContacts.dart
        _textForm()
      ]),
    );
  }
}
