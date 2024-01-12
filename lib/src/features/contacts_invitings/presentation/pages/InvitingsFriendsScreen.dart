import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tally_up/src/core/widgets/view.dart';
import 'package:tally_up/src/features/contacts_invitings/presentation/bloc/invitings/invitings_bloc.dart';

class InvitingsList extends StatefulWidget {
  const InvitingsList({super.key});

  @override
  State<InvitingsList> createState() => _InvitingsListState();
}

class _InvitingsListState extends State<InvitingsList> {
  final _maskFormatter = MaskTextInputFormatter(
      mask: '+7 (###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  final TextEditingController _searchController =
      TextEditingController(); //TODO: впринципе он не особо нужен наверное, пока не понял (как и в loginScreen, посмотреть в LoginScreen может оттуда тоже удалить)
  final _invitingsBloc = InvitingsBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _invitingsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _invitingsBloc,
      child: BlocListener<InvitingsBloc, InvitingsState>(
        listener: (context, state) {
          if (state is PeopleNotFound) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Такого человека пока не зарегестрировано",
                  textAlign: TextAlign.center,
                ),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is PeopleFound) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Ваш запрос отправлен",
                  textAlign: TextAlign.center,
                ),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SearchBarWidget(
                      hint: '+7 (000) 00-00-00',
                      inputFormatters: [_maskFormatter],
                      textInputType: TextInputType.phone,
                      inputController: _searchController,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _invitingsBloc.add(
                        SearchUserForPhone(
                          '+7${_maskFormatter.getUnmaskedText()}',
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 40,
                      color: Color(0xFF0079FF),
                    ),
                  )
                ],
              ),
              const ColumnGapWidget(height: 10),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: BlocBuilder<InvitingsBloc, InvitingsState>(
                        builder: (context, state) {
                          if (state is InvitingsLoaded) {
                            var invitings = state.invitings;
                            if (invitings.isEmpty) {
                              return const Center(
                                child: Text('У вас пока нет приглашений'),
                              );
                            }
                            return ListView.separated(
                              itemCount: invitings.length,
                              separatorBuilder: (context, index) {
                                if (index > 0 &&
                                    invitings[index]['username'][0]
                                            .toUpperCase() ==
                                        invitings[index - 1]['username'][0]
                                            .toUpperCase()) {
                                  return Row(
                                    children: [
                                      Text(invitings[index]['username'][0]),
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
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    child: Text(invitings[index]['username'][0]
                                        .toUpperCase()),
                                  ),
                                  title: Text(invitings[index]['username']),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          context.read<InvitingsBloc>().add(
                                              AcceptUserToContacts(invitings[
                                                      index][
                                                  'contacts_invitings_doc_id']));
                                        },
                                        icon: const Icon(Icons.check),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          context.read<InvitingsBloc>().add(
                                              DiscardUserToContacts(invitings[
                                                      index][
                                                  'contacts_invitings_doc_id']));
                                        },
                                        icon: const Icon(Icons.delete),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
