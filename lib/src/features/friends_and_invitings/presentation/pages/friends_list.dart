import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally_up/src/features/friends_and_invitings/presentation/bloc/contacts/friends_bloc.dart';

class FriendsList extends StatefulWidget {
  const FriendsList({super.key});

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  final _friendsBloc = FriendsBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _friendsBloc.close();
    super.dispose();
  }

  Widget friendsDivider(letter) {
    return Row(
      children: [
        Text(letter),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: Container(
          height: 1,
          color: Colors.black,
        ))
      ],
    );
  }

  Widget friendsListItem(index, friends) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(Icons.circle),
      trailing: IconButton(
        onPressed: () =>
            _friendsBloc.add(DeleteFriend(friends['data_for_delete'])),
        icon: Icon(Icons.delete),
      ),
      title: Text(friends['username']),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _friendsBloc,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<FriendsBloc, FriendsState>(
          builder: (context, state) {
            if (state is FriendsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FriendsLoaded) {
              List friends = state.friends;

              return ListView.separated(
                itemCount: friends.length,
                separatorBuilder: (context, index) {
                  if (index == friends.length - 1) {
                    return const SizedBox.shrink();
                  }
                  String personWithNewLetter =
                      friends[index + 1]['username'][0];
                  if (friends[index]['username'][0] != personWithNewLetter) {
                    return friendsDivider(personWithNewLetter);
                  }
                  return const SizedBox.shrink();
                },
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        friendsDivider(friends[index]['username'][0]),
                        friendsListItem(index, friends[index])
                      ],
                    );
                  }
                  return friendsListItem(index, friends[index]);
                },
              );
            } else if (state is FriendsListEmpty) {
              return const Text('У вас пока нет друзей');
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
