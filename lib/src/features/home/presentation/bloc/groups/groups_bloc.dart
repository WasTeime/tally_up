import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally_up/src/features/home/data/repository/groupsController.dart';

part 'groups_event.dart';
part 'groups_state.dart';

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  final groupsController = GroupsController();
  late final StreamSubscription groupsSub;

  GroupsBloc() : super(GroupsInitial()) {
    groupsSub = groupsController.getGroupsListStream.listen(
      (QuerySnapshot querySnapshot) => add(LoadGroups(querySnapshot)),
    );

    on<LoadGroups>((event, emit) async {
      emit(GroupsLoading());
      await groupsController
          .getGroupsList(event.querySnapshot)
          .then((groupsList) => emit(GroupsLoaded(groupsList)));
    });
  }

  @override
  Future<void> close() {
    groupsSub.cancel();
    return super.close();
  }
}
