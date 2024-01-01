import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tally_up/src/core/layouts/mainLayout.dart';
import 'package:tally_up/src/core/widgets/AppBarWidget.dart';
import 'package:tally_up/src/core/widgets/ColumnGapWidget.dart';
import 'package:tally_up/src/core/widgets/InputWidget.dart';
import 'package:tally_up/src/core/widgets/contacts/ContactsListCardWidget.dart';
import 'package:tally_up/src/core/widgets/LoadingWidget.dart';
import 'package:tally_up/src/features/friends_and_invitings/presentation/bloc/friends/friends_bloc.dart';
import 'package:tally_up/src/features/group/presentation/bloc/create_group/create_group_bloc.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

//todo чет мне кажется что получать доступ к метод через ключ какая-то хуйня, посмотреть другие способы
class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final _groupNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final CreateGroupBloc _createGroupBloc = CreateGroupBloc();
  final FriendsBloc _friendsBloc = FriendsBloc();

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBarWidget: AppBarWidget.withAcceptButton(
        enableAcceptButton: () {
          if (_formKey.currentState!.validate()) {
            List<DocumentReference>? selectedFriends = ContactsListCardWidget
                .globalKey.currentState?.getValidateContacts;
            if (selectedFriends != null) {
              _createGroupBloc.add(
                CreateGroup(
                  _groupNameController.text,
                  selectedFriends,
                ),
              );
            }
          }
        },
        enableBackButton: () => context.go('/'),
        titleWidget: const Text(
          "Создать",
          style: TextStyle(fontSize: 20),
        ),
      ),
      contentWidget: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _createGroupBloc),
          BlocProvider.value(value: _friendsBloc)
        ],
        child: BlocConsumer<CreateGroupBloc, CreateGroupState>(
          listener: (context, state) {
            if (state is CreateGroupLoaded) {
              context.go('/group', extra: state.createdGroupRef);
            }
          },
          builder: (context, state) {
            if (state is CreateGroupLoading) {
              return const LoadingWidget();
            }
            return BlocBuilder<FriendsBloc, FriendsState>(
              builder: (context, state) {
                if (state is FriendsLoaded) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: Form(
                            key: _formKey,
                            child: InputWidget(
                              hintText: "Название",
                              inputController: _groupNameController,
                            ),
                          ),
                        ),
                        const ColumnGapWidget(),
                        Expanded(
                          child: ContactsListCardWidget(
                            data: state.friends,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const LoadingWidget();
              },
            );
          },
        ),
      ),
    );
  }
}
