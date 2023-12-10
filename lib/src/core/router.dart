import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tally_up/src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:tally_up/src/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:tally_up/src/features/auth/presentation/pages/LoginScreen.dart';
import 'package:tally_up/src/features/auth/presentation/pages/PinVerifyScreen.dart';
import 'package:tally_up/src/features/auth/presentation/pages/ProfileScreen.dart';
import 'package:tally_up/src/features/createGroup/presentation/pages/createGroupScreen.dart';
import 'package:tally_up/src/features/friends_and_invitings/presentation/pages/friendsAndInvitingsScreen.dart';
import 'package:tally_up/src/features/cheque_list/presentation/pages/ChequeListInEvent.dart';
import 'package:tally_up/src/features/cheque_list/presentation/pages/DetailedChequeScreen.dart';
import 'package:tally_up/src/features/contacts/presentation/pages/newContact.dart';
import 'package:tally_up/src/features/cheque_list/presentation/pages/CreateNewChequeScreen.dart';
import 'package:tally_up/src/features/cheque_list/presentation/pages/EnterProductsManuallyScreen.dart';
import 'package:tally_up/src/features/group/presentation/pages/GroupScreen.dart';
import 'package:tally_up/src/features/home/presentation/pages/HomeScreen.dart';

import '../features/auth/presentation/pages/HomeScreanArchive.dart';

final signInBloc = SignInBloc();

final router = GoRouter(initialLocation: '/loginState', routes: [
  GoRoute(
    path: '/loginState',
    builder: (context, state) {
      return BlocProvider(
        create: (context) => AuthBloc(),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.authenticated) {
              context.go('/');
            } else {
              context.go('/login');
            }
          },
          child: const SizedBox.shrink(),
        ),
      );
    },
  ),
  GoRoute(
      path: '/',
      builder: (context, state) {
        signInBloc.dispose();
        return HomeScreen();
      }),
  GoRoute(
    path: '/friendsAndInvitings',
    builder: (context, state) => FriendsAndInvitingsScreen(),
  ),
  GoRoute(
    path: '/createGroup',
    builder: (context, state) => CreateGroupScreen(),
  ),
  GoRoute(
      path: '/group',
      builder: (context, state) {
        return GroupScreen(
          groupRef: state.extra as DocumentReference,
        );
      }),
  GoRoute(
    path: '/login',
    builder: (context, state) {
      return BlocProvider<SignInBloc>.value(
        value: signInBloc,
        child: LoginScreen(),
      );
    },
  ),
  GoRoute(
      path: '/smsCodeVerify',
      builder: (context, state) {
        return BlocProvider<SignInBloc>.value(
            value: signInBloc, child: PinVerifyScreen());
      }),
  GoRoute(
      path: '/arhive',
      builder: (context, state) {
        return BlocProvider<SignInBloc>.value(
            value: signInBloc, child: HomeScreanArchive());
      }),
  GoRoute(
      path: '/profile',
      builder: (context, state) {
        return BlocProvider<SignInBloc>.value(
            value: signInBloc, child: ProfileScreen());
      }),
  GoRoute(
      path: '/cheque',
      builder: (context, state) {
        return BlocProvider<SignInBloc>.value(
            value: signInBloc, child: ChequeListInEvent());
      }),
]);
