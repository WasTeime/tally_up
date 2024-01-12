import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tally_up/src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:tally_up/src/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:tally_up/src/features/auth/presentation/pages/LoginScreen.dart';
import 'package:tally_up/src/features/auth/presentation/pages/PinVerifyScreen.dart';
import 'package:tally_up/src/features/cheque/presentation/pages/ChequeScreen.dart';
import 'package:tally_up/src/features/cheque/presentation/pages/variants_for_input_cheque/CreateChequeManuallyScreen.dart';
import 'package:tally_up/src/features/cheque/presentation/pages/variants_for_input_cheque/CreateChequeQRScannerScreen.dart';
import 'package:tally_up/src/features/contacts_invitings/presentation/pages/ContactsInvitingsScreen.dart';
import 'package:tally_up/src/features/event/presentation/pages/EventScreen.dart';
import 'package:tally_up/src/features/event/presentation/pages/createEventScreen.dart';
import 'package:tally_up/src/features/profile/presentation/pages/ProfileScreen.dart';
import 'package:tally_up/src/features/group/presentation/pages/createGroupScreen.dart';
import 'package:tally_up/src/features/group/presentation/pages/GroupScreen.dart';
import 'package:tally_up/src/features/home/presentation/pages/HomeScreen.dart';

final signInBloc = SignInBloc();

//todo подключить все страницы
//todo сделать структуру типо /group/create, а не /group, /createGroup
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
    },
  ),
  GoRoute(
    path: '/contactsAndInvitings',
    builder: (context, state) => ContactsInvitingsScreen(
      currentTabIndex: state.extra as int,
    ),
  ),
  GoRoute(
    path: '/createGroup',
    builder: (context, state) => CreateGroupScreen(),
  ),
  GoRoute(
    path: '/chequeEnterManually',
    builder: (context, state) => CreateChequeManuallyScreen(),
  ),
  GoRoute(
    path: '/group',
    builder: (context, state) {
      return GroupScreen(
        groupRef: state.extra as DocumentReference,
      );
    },
  ),
  GoRoute(
    path: '/event',
    builder: (context, state) => EventScreen(
      eventRef: state.extra as DocumentReference,
    ),
  ),
  GoRoute(
    path: '/createEvent',
    builder: (context, state) => CreateEventScreen(
      groupRef: state.extra as DocumentReference,
    ),
  ),
  GoRoute(
    path: '/cheque',
    builder: (context, state) => ChequeScreen(
      chequeRef: state.extra as DocumentReference,
    ),
  ),
  GoRoute(
    path: '/createCheque',
    builder: (context, state) => CreateChequeQRScannerScreen(
      eventRef: state.extra as DocumentReference,
    ),
  ),
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
        value: signInBloc,
        child: PinVerifyScreen(),
      );
    },
  ),
  GoRoute(
    path: '/profile',
    builder: (context, state) {
      return BlocProvider<SignInBloc>.value(
        value: signInBloc,
        child: ProfileScreen(),
      );
    },
  ),
]);
