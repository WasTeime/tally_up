import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tally_up/bricks/CoreWidgets/searchbarwidget.dart';
import 'package:tally_up/src/core/widgets/ColumnGapWidget.dart';
import 'package:tally_up/src/core/widgets/InputFieldWidget.dart';
import 'package:tally_up/src/features/createGroup/presentation/bloc/create_group/create_group_bloc.dart';
import 'package:tally_up/src/features/friends_and_invitings/presentation/pages/friends_list.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  TextEditingController _groupNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ValueNotifier<bool> isFriendsSelected = ValueNotifier(true);
  final CreateGroupBloc _createGroupBloc = CreateGroupBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _createGroupBloc,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => context.go('/'),
          ),
          elevation: 10,
          actions: [
            IconButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (FriendsList.globalKey.currentState!
                        .getSelectedFriends()
                        .isEmpty) {
                      isFriendsSelected.value = false;
                    } else {
                      isFriendsSelected.value = true;
                      _createGroupBloc.add(
                        CreateGroup(
                            _groupNameController.text,
                            FriendsList.globalKey.currentState!
                                .getSelectedFriends()),
                      );
                    }
                  }
                },
                icon: const Icon(Icons.check))
          ],
        ),
        body: BlocConsumer<CreateGroupBloc, CreateGroupState>(
          listener: (context, state) {
            if (state is CreateGroupLoaded) {
              context.go('/group', extra: state.createdGroupRef);
            }
          },
          builder: (context, state) {
            if (state is CreateGroupLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    const ColumnGapWidget(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _groupNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Введите название группы';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const ColumnGapWidget(),
                    SearchBarWidget(),
                    const ColumnGapWidget(),
                    Expanded(
                      child: ValueListenableBuilder(
                        valueListenable: isFriendsSelected,
                        builder: (context, value, child) {
                          return Column(
                            children: [
                              Visibility(
                                visible:
                                    !isFriendsSelected.value ? true : false,
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
                              ),
                              Expanded(
                                child: Card(
                                  color: Colors.white,
                                  shape: !isFriendsSelected.value
                                      ? const RoundedRectangleBorder(
                                          side: BorderSide(
                                            color: Colors.redAccent,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)))
                                      : null,
                                  elevation: 5,
                                  child: FriendsList(
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
              ),
            );
          },
        ),
      ),
    );
  }
}
