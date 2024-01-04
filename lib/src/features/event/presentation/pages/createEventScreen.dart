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
    return BlocProvider.value(
      value: _eventBloc,
      child: BlocBuilder<EventBloc, EventState>(
        builder: (context, state) {
          if (state is EventLoaded) {
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
                enableBackButton: () => context.go('/'),
                titleWidget: const Text(
                  "Создать",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              subAppBarWidget: Row(
                children: [
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: InputWidget(
                        inputController: _eventNameController,
                        hintText: "Название мероприятия",
                      ),
                    ),
                  ),
                  const ChooseEventIconWidget(),
                ],
              ),
              contentWidget: Container(),
            );
          }
          return const LoadingOnWhiteBackgroundWidget();
        },
      ),
    );
  }
}
