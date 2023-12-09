import 'package:flutter_bloc/flutter_bloc.dart';

part 'groups_event.dart';
part 'groups_state.dart';

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  GroupsBloc() : super(GroupsInitial()) {
    on<LoadGroups>((event, emit) {});
  }
}
