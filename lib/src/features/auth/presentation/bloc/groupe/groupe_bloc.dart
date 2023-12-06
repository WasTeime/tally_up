import 'package:flutter_bloc/flutter_bloc.dart';

part 'groupe_event.dart';
part 'groupe_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  GroupBloc() : super(GroupLoading()) {
    on<LoadGroupList>((event, emit) async {
      await Future.delayed(Duration(seconds: 2));
      emit(GroupLoaded());
    });
  }
}
