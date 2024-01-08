import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally_up/src/features/group/data/repository/groupController.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final GroupController _groupController = GroupController();
  late final StreamSubscription _groupEventsSub;

  GroupBloc({DocumentReference? groupRef}) : super(GroupInitial()) {
    //если groupRef == null значит мы создаем группу и поэтому ссылки на неё нет
    if (groupRef != null) {
      _groupEventsSub =
          _groupController.getGroupEventsListStream(groupRef: groupRef).listen(
                (QuerySnapshot querySnapshot) => add(
                  LoadGroup(querySnapshot, groupRef: groupRef),
                ),
              );
    }

    on<LoadGroup>((event, emit) async {
      emit(GroupLoading());
      await _groupController
          .getGroupData(
            groupRef: event.groupRef,
          )
          .then((data) => emit(GroupLoaded(data)));
    });

    on<CreateGroup>((event, emit) async {
      emit(GroupCreating());

      await _groupController
          .createGroup(event.groupName, event.groupParticipants)
          .then((createdGroupRef) => emit(GroupCreated(createdGroupRef)));
    });
  }

  @override
  Future<void> close() {
    _groupEventsSub.cancel();
    return super.close();
  }
}
