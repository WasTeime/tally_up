import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tally_up/bricks/CoreWidgets/searchbarwidget.dart';
import 'package:tally_up/src/core/widgets/ColumnGapWidget.dart';
import 'package:tally_up/src/features/auth/presentation/widgets/InputFieldWidget.dart';
import 'package:tally_up/src/core/widgets/LoadingWidget.dart';
import 'package:tally_up/src/core/widgets/contactsList.dart';
import 'package:tally_up/src/features/createGroup/presentation/bloc/create_group/create_group_bloc.dart';
import 'package:tally_up/src/features/createGroup/presentation/widgets/view.dart';
import 'package:tally_up/src/features/friends_and_invitings/presentation/bloc/friends/friends_bloc.dart';
import 'package:tally_up/src/features/friends_and_invitings/presentation/pages/FriendsScreen.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final _groupNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ValueNotifier<bool> isFriendsSelected = ValueNotifier(true);

  final CreateGroupBloc _createGroupBloc = CreateGroupBloc();
  final FriendsBloc _friendsBloc = FriendsBloc();

  Widget isShowselectedContactsError(bool isFriendsSelected) {
    return Visibility(
      visible: !isFriendsSelected ? true : false,
      child: const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Выберите друзей",
          style: TextStyle(
            fontSize: 15,
            color: Colors.redAccent,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Создать",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
        leading: BackButton(
          onPressed: () => context.go('/'),
        ),
        actions: [
          IconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final selectedFriends = ContactsList.globalKey.currentState!
                      .getListRefsForSelectedPeople();
                  if (selectedFriends.isEmpty) {
                    isFriendsSelected.value = false;
                  } else {
                    isFriendsSelected.value = true;
                    _createGroupBloc.add(
                      CreateGroup(_groupNameController.text, selectedFriends),
                    );
                  }
                }
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: MultiBlocProvider(
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
                          child: ValueListenableBuilder(
                            valueListenable: isFriendsSelected,
                            builder: (__, isFriendsSelected, _) {
                              return Column(
                                children: [
                                  isShowselectedContactsError(
                                    isFriendsSelected,
                                  ),
                                  Expanded(
                                    child: Card(
                                      color: Colors.white,
                                      shape: !isFriendsSelected
                                          ? const RoundedRectangleBorder(
                                              side: BorderSide(
                                                color: Colors.redAccent,
                                                width: 2,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)))
                                          : null,
                                      elevation: 5,
                                      child: ContactsList(
                                        contacts: state.friends,
                                        enableCheckboxes: true,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
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
