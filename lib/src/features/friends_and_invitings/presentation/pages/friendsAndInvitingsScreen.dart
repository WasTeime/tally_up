import 'package:flutter/material.dart';
import 'package:tally_up/src/features/friends_and_invitings/presentation/pages/friends_list.dart';
import 'package:tally_up/src/features/friends_and_invitings/presentation/pages/invitings_list.dart';

class FriendsAndInvitingsScreen extends StatefulWidget {
  const FriendsAndInvitingsScreen({super.key});

  @override
  State<FriendsAndInvitingsScreen> createState() =>
      _FriendsAndInvitingsScreenState();
}

class _FriendsAndInvitingsScreenState extends State<FriendsAndInvitingsScreen> {
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
                FriendsList(
                  enableCheckboxes: false,
                ),
                InvitingsList()
              ]),
            )
          ]),
        ));
  }
}
