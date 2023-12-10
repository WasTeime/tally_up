import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally_up/src/features/group/data/repository/groupController.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  late final GroupController _groupController;
  late final StreamSubscription groupEventsSub;
  final DocumentReference groupRef;

  GroupBloc({required this.groupRef}) : super(GroupInitial()) {
    _groupController = GroupController(groupRef: groupRef);

    groupEventsSub = _groupController.getGroupEventsListStream
        .listen((QuerySnapshot querySnapshot) => add(LoadGroup(querySnapshot)));

    on<LoadGroup>((event, emit) async {
      emit(GroupLoading());
      await _groupController
          .getGroupDataWithEvents(event.querySnapshot)
          .then((data) => emit(GroupLoaded(data)));
    });
  }

  @override
  Future<void> close() {
    groupEventsSub.cancel();
    return super.close();
  }
}
