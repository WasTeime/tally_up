import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tally_up/src/core/widgets/view.dart';

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
    contacts = widget.contacts;
    super.initState();
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
    final theme = Theme.of(context);
    return Row(
      children: [
        Text(letter, style: theme.textTheme.bodyMedium),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            height: 1,
            color: Color(0xff50A3FF),
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          );
        },
      );
    }
    return IconButton(onPressed: () {}, icon: const Icon(Icons.delete));
  }

  Widget contactsListItem(
    Map<String, dynamic> contactData, {
    Widget contactAvatar = const Icon(
      Icons.circle,
      color: Color(0xff8EBBFF),
    ),
  }) {
    final theme = Theme.of(context);
    return ListTile(
      leading: contactAvatar,
      title: Text(contactData['username'],
          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black)),
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
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Добавьте своего первого друга",
              style: TextStyle(fontSize: 20),
            ),
            const ColumnGapWidget(),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              //в extra находится индекс для tabBar
              onPressed: () => context.push('/contactsAndInvitings', extra: 1),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
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
