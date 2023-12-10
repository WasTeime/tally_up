import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally_up/src/features/createGroup/data/repository/createGroupContoller.dart';

part 'create_group_event.dart';
part 'create_group_state.dart';

class CreateGroupBloc extends Bloc<CreateGroupEvent, CreateGroupState> {
  final _createGroupController = CreateGroupController();

  CreateGroupBloc() : super(CreateGroupInitial()) {
    on<CreateGroup>((event, emit) async {
      emit(CreateGroupLoading());
      await _createGroupController
          .createGroup(event.groupName, event.groupParticipants)
          .then((createdGroupRef) => emit(CreateGroupLoaded(createdGroupRef)));
    });
  }
}
