import 'package:flutter/material.dart';
import 'package:tally_up/src/features/contacts_invitings/presentation/pages/ContactsScreen.dart';
import 'package:tally_up/src/features/contacts_invitings/presentation/pages/InvitingsFriendsScreen.dart';

class ContactsInvitingsScreen extends StatefulWidget {
  const ContactsInvitingsScreen({super.key});

  @override
  State<ContactsInvitingsScreen> createState() =>
      _ContactsInvitingsScreenState();
}

class _ContactsInvitingsScreenState extends State<ContactsInvitingsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Друзья и приглашения",
              style: TextStyle(fontSize: 15),
            ),
          ),
          body: Column(children: [
            const TabBar(
              tabs: [
                Tab(
                  text: 'друзья',
                ),
                Tab(
                  text: 'приглашения',
                ),
              ],
            ),
            Expanded(
              child: TabBarView(children: [
                FriendsScreen(),
                InvitingsList(),
              ]),
            )
          ]),
        ));
  }
}
