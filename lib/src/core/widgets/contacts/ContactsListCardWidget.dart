import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally_up/src/core/widgets/contacts/ContactsListWidget.dart';

class ContactsListCardWidget extends StatefulWidget {
  final List<Map<String, dynamic>> data;

  static final GlobalKey<_ContactsListCardWidgetState> globalKey = GlobalKey();

  ContactsListCardWidget({
    required this.data,
  }) : super(key: globalKey);

  @override
  State<ContactsListCardWidget> createState() => _ContactsListCardWidgetState();
}

class _ContactsListCardWidgetState extends State<ContactsListCardWidget> {
  ValueNotifier<bool> isPeopleSelected = ValueNotifier(true);

  List<DocumentReference>? get getValidateContacts {
    final selectedPeople = ContactsListWidget.globalKey.currentState!
        .getListRefsForSelectedPeople();
    if (selectedPeople.isEmpty) {
      isPeopleSelected.value = false;
      return null;
    } else {
      isPeopleSelected.value = true;
      return selectedPeople;
    }
  }

  Widget errorText() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "Выберите друзей",
        style: TextStyle(
          fontSize: 15,
          color: Colors.redAccent,
        ),
      ),
    );
  }

  Widget errorContainerBorder() {
    return Container(
      decoration: BoxDecoration(
        border: !isPeopleSelected.value
            ? Border.all(
                color: Colors.redAccent,
                width: 2,
              )
            : null,
        borderRadius: !isPeopleSelected.value
            ? BorderRadius.all(Radius.circular(10))
            : null,
      ),
      height: 5,
      child: ContactsListWidget(
        contacts: widget.data,
        enableCheckboxes: true,
      ),
    );
  }

//Оставил с карточкой, изменил на контейнер, чтобы цвет был белым

  // Widget errorContainerBorder() {
  //   return Card(
  //     color: Colors.white,
  //     shape: !isPeopleSelected.value
  //         ? const RoundedRectangleBorder(
  //             side: BorderSide(
  //               color: Colors.redAccent,
  //               width: 2,
  //             ),
  //             borderRadius: BorderRadius.all(Radius.circular(10)))
  //         : null,
  //     elevation: 5,
  //     child: ContactsListWidget(
  //       contacts: widget.data,
  //       enableCheckboxes: true,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isPeopleSelected,
      builder: (__, isPeopleSelected, _) {
        return Column(
          children: [
            Visibility(
              visible: !isPeopleSelected ? true : false,
              child: errorText(),
            ),
            Expanded(
              child: errorContainerBorder(),
            ),
          ],
        );
      },
    );
  }
}
