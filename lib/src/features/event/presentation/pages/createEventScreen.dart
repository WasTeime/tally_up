import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tally_up/src/core/layouts/mainLayout.dart';
import 'package:tally_up/src/core/widgets/view.dart';
import 'package:tally_up/src/features/event/presentation/bloc/event/event_bloc.dart';
import 'package:tally_up/src/features/event/presentation/widgets/ChooseEventIconWidget.dart';

class CreateEventScreen extends StatefulWidget {
  final DocumentReference groupRef;
  const CreateEventScreen({
    super.key,
    required this.groupRef,
  });

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _eventNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late final EventBloc _eventBloc;

  @override
  void initState() {
    _eventBloc = EventBloc(groupRef: widget.groupRef);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider.value(
      value: _eventBloc,
      child: BlocBuilder<EventBloc, EventState>(
        builder: (context, state) {
          return MainLayout(
            appBarWidget: AppBarWidget.withAcceptButton(
              enableAcceptButton: () {
                if (_formKey.currentState!.validate()) {
                  _eventBloc.add(
                    CreateGroupEvent(
                      eventName: _eventNameController.text,
                    ),
                  );
                }
              },
              enableBackButton: () =>
                  context.canPop() ? context.pop() : context.go('/'),
              titleWidget: Text(
                "Создать",
                style: theme.textTheme.headlineMedium
                    ?.copyWith(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            subAppBarWidget: Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Container(
                    height: 50,
                    child: Form(
                      key: _formKey,
                      child: InputWidget(
                        inputController: _eventNameController,
                        hintText: "Название мероприятия",
                        fillColor: Color(0XFF0079FF),
                        hintColor: Colors.white,
                      ),
                    ),
                  ),
                )),
                const ChooseEventIconWidget(),
              ],
            ),
            contentWidget: Container(),
          );
        },
      ),
    );
  }
}
