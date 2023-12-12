import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally_up/src/core/widgets/SearchWidget.dart';

class ContactsListWidget extends StatefulWidget {
  final bool enableCheckboxes;
  final bool enableSearch;
  final List<Map<String, dynamic>> contacts;
  //https://stackoverflow.com/questions/53692798/flutter-calling-child-class-function-from-parent-class
  static final GlobalKey<_ContactsListWidgetState> globalKey = GlobalKey();
  ContactsListWidget({
    required this.contacts,
    this.enableCheckboxes = false,
    this.enableSearch = true,
  }) : super(key: globalKey);

  @override
  State<ContactsListWidget> createState() => _ContactsListWidgetState();
}

class _ContactsListWidgetState extends State<ContactsListWidget> {
  //todo можно не только ссылку в бд хранить, но например и фотку с именем как поля в документе
  late List<Map<String, dynamic>> contacts;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    contacts = widget.contacts;
  }

  List<DocumentReference> getListRefsForSelectedPeople() {
    List<DocumentReference> selectedPeople = [];
    for (Map<String, dynamic> contact in contacts) {
      if (contact['check'].value == true) {
        selectedPeople.add(contact['user_ref']);
      }
    }
    return selectedPeople;
  }

  Widget contactsListDivider(letter) {
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
          ),
        )
      ],
    );
  }

  Widget contactsListItemTrailingWidget(
    ValueNotifier<bool> checkboxIsChecked,
  ) {
    if (widget.enableCheckboxes) {
      return ValueListenableBuilder(
        valueListenable: checkboxIsChecked,
        builder: (context, bool value, child) {
          return Checkbox(
            value: value,
            onChanged: (onChanged) {
              checkboxIsChecked.value = onChanged!;
            },
          );
        },
      );
    }
    return IconButton(onPressed: () {}, icon: const Icon(Icons.delete));
  }

  Widget contactsListItem(
    Map<String, dynamic> contactData, {
    Widget contactAvatar = const Icon(Icons.circle),
  }) {
    return ListTile(
      leading: contactAvatar,
      title: Text(contactData['username']),
      trailing: contactsListItemTrailingWidget(contactData['check']),
    );
  }

  Widget contactsList() {
    return ListView.separated(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              contactsListDivider(contacts[index]['username'][0]),
              contactsListItem(contacts[index]),
            ],
          );
        }
        return contactsListItem(contacts[index]);
      },
      separatorBuilder: (context, index) {
        if (index < contacts.length - 1) {
          String personWithNewLetter = contacts[index + 1]['username'][0];
          if (contacts[index]['username'][0] != personWithNewLetter) {
            return contactsListDivider(personWithNewLetter);
          }
        }
        return const SizedBox.shrink();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (contacts.isEmpty) {
      return const Center(
        child: Text("У вас пока нет друзей"),
      );
    }
    if (widget.enableSearch) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: SearchWidget(textController: searchController),
          ),
          Expanded(child: contactsList())
        ],
      );
    }
    return contactsList();
  }
}
