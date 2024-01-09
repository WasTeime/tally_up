
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:tally_up/src/core/data/Controller.dart';
import 'package:tally_up/src/core/theme.dart';
import 'package:tally_up/src/features/group/data/models/GroupsDBModel.dart';
import 'package:tally_up/src/features/group/data/repository/groupController.dart';
import 'package:tally_up/src/features/group/presentation/bloc/group/group_bloc.dart';
import 'package:tally_up/src/features/home/data/repository/groupsController.dart';
import 'package:tally_up/src/features/home/presentation/bloc/groups/groups_bloc.dart';
import 'package:tally_up/src/features/home/presentation/pages/HomeScreen.dart';
import 'package:tally_up/src/features/home/presentation/widgets/TabBarWidget.dart';

import '../Mock.dart';

class FirebaseMock extends Mock implements Firebase {}
class GroupsBlocMock extends Mock implements GroupsBloc {}
class MockController extends Mock implements Controller {}
class GroupsControllerMock extends Mock implements GroupsController {}
class GroupControllerMock extends Mock implements GroupController {}



void main(){
  setupFirebaseAuthMocks();

  setUpAll(() async {
    GetIt.I.registerLazySingleton<AppTheme>(() => AppTheme());
    await Firebase.initializeApp();

  });
  
  testWidgets('Check if AppBar is present', (WidgetTester tester) async {
    final mockController = Controller();

    when(mockController.getUserUid).thenReturn('123');

    final groupsControllerMock = GroupsController();
    final groupControllerMock = GroupController();
    final groupsBloc = GroupsBloc();

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<GroupsBloc>.value(
          value: groupsBloc,
          child: const HomeScreen(),
          ),
      ),
    );
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(HomeTabBarWidget), findsOneWidget);
    expect(find.byType(HomeTabBarScreens), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    
  });

}