import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tally_up/src/core/widgets/view.dart';
import 'package:tally_up/src/features/friends_and_invitings/presentation/bloc/invitings/invitings_bloc.dart';

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
  var arr = ["1", "2", "3"];
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
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Такого человека пока не зарегестрировано",
                      textAlign: TextAlign.center),
                  backgroundColor: Colors.red));
            } else if (state is PeopleFound) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content:
                      Text("Ваш запрос отправлен", textAlign: TextAlign.center),
                  backgroundColor: Colors.green));
            }
          },
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                Expanded(
                    flex: 1,
                    child: Container(
                        color: Colors.green,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SearchBarWidget(
                              hint: '+7 (000) 00-00-00',
                              inputFormatters: [_maskFormatter],
                              textInputType: TextInputType.phone,
                              inputController: _searchController,
                            ),
                            IconButton(
                                onPressed: () {
                                  _invitingsBloc.add(SearchUserForPhone(
                                      '+7${_maskFormatter.getUnmaskedText()}'));
                                },
                                icon: Icon(Icons.add))
                          ],
                        ))),
                Expanded(
                    flex: 5,
                    child: Container(
                        color: Colors.amber,
                        child: Column(children: [
                          const Text(
                            "Приглашения",
                            style: TextStyle(fontSize: 25),
                          ),
                          Expanded(
                              child: BlocBuilder<InvitingsBloc, InvitingsState>(
                            builder: (context, state) {
                              if (state is InvitingsLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is InvitingsLoaded) {
                                var invitings = state.invitings;
                                return ListView.builder(
                                    itemCount: invitings.length,
                                    itemBuilder: (context, index) {
                                      return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(invitings[index]['username']),
                                            Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      context
                                                          .read<InvitingsBloc>()
                                                          .add(AcceptUserToFriends(
                                                              invitings[index][
                                                                  'friends_invitings_doc_id']));
                                                    },
                                                    icon: const Icon(
                                                        Icons.check)),
                                                IconButton(
                                                    onPressed: () {
                                                      context
                                                          .read<InvitingsBloc>()
                                                          .add(DiscardUserToFriends(
                                                              invitings[index][
                                                                  'friends_invitings_doc_id']));
                                                    },
                                                    icon: const Icon(
                                                        Icons.delete)),
                                              ],
                                            )
                                          ]);
                                    });
                              }
                              return const SizedBox.shrink();
                            },
                          ))
                        ])))
              ]),
            ),
          ),
        ));
  }
}
