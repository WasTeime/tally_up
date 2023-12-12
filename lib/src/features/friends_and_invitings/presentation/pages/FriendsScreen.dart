import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally_up/src/core/widgets/contactsListWidget.dart';
import 'package:tally_up/src/features/friends_and_invitings/presentation/bloc/friends/friends_bloc.dart';

class FriendsScreen extends StatefulWidget {
  //https://stackoverflow.com/questions/53692798/flutter-calling-child-class-function-from-parent-class
  static final GlobalKey<_FriendsScreenState> globalKey = GlobalKey();
  FriendsScreen() : super(key: globalKey);

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  final _friendsBloc = FriendsBloc();

  @override
  void dispose() {
    _friendsBloc.close();
    super.dispose();
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
              return ContactsListWidget(
                contacts: state.friends,
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


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tally_up/src/features/friends_and_invitings/presentation/bloc/friends/friends_bloc.dart';

// class FriendsList extends StatefulWidget {
//   final bool enableCheckboxes;
//   //todo!https://stackoverflow.com/questions/53692798/flutter-calling-child-class-function-from-parent-class
//   static final GlobalKey<_FriendsListState> globalKey = GlobalKey();
//   FriendsList({
//     required this.enableCheckboxes,
//   }) : super(key: globalKey);

//   @override
//   State<FriendsList> createState() => _FriendsListState();
// }

// class _FriendsListState extends State<FriendsList> {
//   final _friendsBloc = FriendsBloc();
//   List<Map<String, dynamic>> friends = [];

//   @override
//   void initState() {
//     super.initState();
//   }

//   List<DocumentReference> getSelectedFriends() {
//     List<DocumentReference> selectedFriends = [];
//     for (final element in friends) {
//       if (element['check'].value == true) {
//         selectedFriends.add(element['user_ref']);
//       }
//     }
//     return selectedFriends;
//   }

//   @override
//   void dispose() {
//     _friendsBloc.close();
//     super.dispose();
//   }

//   Widget friendsDivider(letter) {
//     return Row(
//       children: [
//         Text(letter),
//         const SizedBox(
//           width: 10,
//         ),
//         Expanded(
//             child: Container(
//           height: 1,
//           color: Colors.black,
//         ))
//       ],
//     );
//   }

//   Widget friendsListItemWithCheckbox(index, friends) {
//     Widget checkBox = ValueListenableBuilder(
//       valueListenable: friends['check'],
//       builder: (context, bool value, child) {
//         return Checkbox(
//             value: value,
//             onChanged: (onChanged) {
//               friends['check'].value = onChanged!;
//             });
//       },
//     );
//     return friendsListItem(index, friends, widget: checkBox);
//   }

//   Widget friendsListItem(index, friends,
//       {Widget widget = const Icon(Icons.circle)}) {
//     return ListTile(
//       leading: widget,
//       trailing: IconButton(
//         onPressed: () =>
//             _friendsBloc.add(DeleteFriend(friends['data_for_delete'])),
//         icon: Icon(Icons.delete),
//       ),
//       title: Text(friends['username']),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider.value(
//       value: _friendsBloc,
//       child: Padding(
//         padding: const EdgeInsets.all(10),
//         child: BlocBuilder<FriendsBloc, FriendsState>(
//           builder: (context, state) {
//             if (state is FriendsLoading) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (state is FriendsLoaded) {
//               friends = state.friends;
//               // friends.forEach((element) {
//               //   element['check'] = ValueNotifier(false);
//               // });
//               return ListView.separated(
//                 itemCount: friends.length,
//                 separatorBuilder: (context, index) {
//                   if (index == friends.length - 1) {
//                     return const SizedBox.shrink();
//                   }
//                   String personWithNewLetter =
//                       friends[index + 1]['username'][0];
//                   if (friends[index]['username'][0] != personWithNewLetter) {
//                     return friendsDivider(personWithNewLetter);
//                   }
//                   return const SizedBox.shrink();
//                 },
//                 itemBuilder: (context, index) {
//                   if (index == 0) {
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         friendsDivider(friends[index]['username'][0]),
//                         widget.enableCheckboxes
//                             ? friendsListItemWithCheckbox(index, friends[index])
//                             : friendsListItem(index, friends[index])
//                       ],
//                     );
//                   }
//                   return widget.enableCheckboxes
//                       ? friendsListItemWithCheckbox(index, friends[index])
//                       : friendsListItem(index, friends[index]);
//                 },
//               );
//             } else if (state is FriendsListEmpty) {
//               return const Text('У вас пока нет друзей');
//             }
//             return const SizedBox.shrink();
//           },
//         ),
//       ),
//     );
//   }
// }
