import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tally_up/src/core/layouts/mainLayout.dart';
import 'package:tally_up/src/core/widgets/view.dart';
import 'package:tally_up/src/features/contacts_invitings/presentation/bloc/contacts/contacts_bloc.dart';
import 'package:tally_up/src/features/group/presentation/bloc/group/group_bloc.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

//todo чет мне кажется что получать доступ к метод через ключ какая-то хуйня, посмотреть другие способы
class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final _groupNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final GroupBloc _groupBloc = GroupBloc();
  final ContactsBloc _contactsBloc = ContactsBloc();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _groupBloc),
        BlocProvider.value(value: _contactsBloc),
      ],
      child: BlocListener<GroupBloc, GroupState>(
        listener: (context, state) {
          if (state is GroupCreated) {
            context.go('/group', extra: state.createdGroupRef);
          }
        },
        child: BlocBuilder<ContactsBloc, ContactsState>(
          builder: (context, state) {
            if (state is ContactsLoaded) {
              return MainLayout(
                appBarWidget: AppBarWidget.withAcceptButton(
                  enableAcceptButton: () {
                    if (_formKey.currentState!.validate()) {
                      List<DocumentReference>? selectedContacts =
                          ContactsListCardWidget
                              .globalKey.currentState?.getValidateContacts;
                      if (selectedContacts != null) {
                        _groupBloc.add(
                          CreateGroup(
                            _groupNameController.text,
                            selectedContacts,
                          ),
                        );
                      }
                    }
                  },
                  enableBackButton: () => context.pop(),
                  titleWidget: Text(
                    "Создать",
                    style: theme.textTheme.headlineMedium
                        ?.copyWith(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                subAppBarWidget: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Container(
                      height: 50,
                      child: Form(
                        key: _formKey,
                        child: InputWidget(
                          hintText: "Название",
                          inputController: _groupNameController,
                          fillColor: Color(0XFF0079FF),
                          hintColor: Colors.white,
                        ),
                      ),
                    )),
                contentWidget: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ContactsListCardWidget(
                      data: state.contacts,
                    ),
                  ),
                ),
              );
            }
            return const LoadingOnWhiteBackgroundWidget();
          },
        ),
      ),
    );
  }
}
