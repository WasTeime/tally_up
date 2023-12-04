import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally_up/src/features/friends_and_invitings/presentation/bloc/contacts/contacts_bloc.dart';

class FriendsList extends StatefulWidget {
  const FriendsList({super.key});

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  // var contacts = [
  //   'Миша',
  //   'Маша',
  //   'Андерей',
  //   'Никита',
  //   'Алеся',
  //   'Mathew',
  //   'Michael',
  //   'Nastya'
  // ];
  @override
  void initState() {
    //contacts.sort();
    super.initState();
  }

  Widget contactsDivider(letter) {
    return Row(
      children: [
        Text(letter),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            flex: 12,
            child: Container(
              height: 1,
              color: Colors.black,
            ))
      ],
    );
  }

  Widget contactsListItem(index, username) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(Icons.circle),
      title: Text(username),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactsBloc()..add(ContactsLoadingEvent()),
      child: Scaffold(
          body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              child: Column(
                children: [
                  const Text(
                    'Контакты',
                    style: TextStyle(fontSize: 25),
                  ),
                  Expanded(
                    child: BlocBuilder<ContactsBloc, ContactsState>(
                      builder: (context, state) {
                        if (state is ContactsLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is ContactsLoaded) {
                          var contacts = state.contacts;
                          return ListView.separated(
                            padding: EdgeInsets.zero,
                            itemCount: contacts.length,
                            separatorBuilder: (context, index) {
                              if (index == contacts.length - 1) {
                                return const SizedBox.shrink();
                              }
                              String personWithNewLetter =
                                  contacts[index + 1]['username'][0];
                              if (contacts[index]['username'][0] !=
                                  personWithNewLetter) {
                                return contactsDivider(personWithNewLetter);
                              }
                              return const SizedBox.shrink();
                            },
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    contactsDivider(contacts[0]['username'][0]),
                                    contactsListItem(
                                        index, contacts[0]['username'])
                                  ],
                                );
                              }
                              return contactsListItem(
                                  index, contacts[0]['username']);
                            },
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              ))),
    );
  }
}
