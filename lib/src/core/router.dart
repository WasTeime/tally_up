import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tally_up/src/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:tally_up/src/features/auth/presentation/pages/HomePage.dart';
import 'package:tally_up/src/features/auth/presentation/pages/LoginScreen.dart';
import 'package:tally_up/src/features/auth/presentation/pages/PinVerifyScreen.dart';
import 'package:tally_up/src/features/cheque_list/presentation/pages/ChequeListInEvent.dart';
import 'package:tally_up/src/features/cheque_list/presentation/pages/DetailedChequeScreen.dart';
import 'package:tally_up/src/features/contacts/presentation/pages/newContact.dart';
import 'package:tally_up/src/features/groups_list/presentation/pages/EventsScreen.dart';
import 'package:tally_up/src/features/groups_list/presentation/pages/GroupScreen.dart';
import 'package:tally_up/src/features/cheque_list/presentation/pages/CreateNewChequeScreen.dart';
import 'package:tally_up/src/features/cheque_list/presentation/pages/AddObjectScreen.dart';

final authBloc = SignInBloc();

final router = GoRouter(initialLocation: '/chek', routes: [
  GoRoute(
      path: '/',
      builder: (context, state) {
        authBloc.dispose();
        return const GroupScreen();
      }),
  GoRoute(
    path: '/login',
    builder: (context, state) {
      return BlocProvider<SignInBloc>.value(
        value: authBloc,
        child: LoginScreen(),
      );
    },
  ),
  GoRoute(
      path: '/smsCodeVerify',
      builder: (context, state) {
        return BlocProvider<SignInBloc>.value(
            value: authBloc, child: PinVerifyScreen());
      }),
  GoRoute(
      path: '/chek',
      builder: (context, state) {
        return BlocProvider<SignInBloc>.value(
            value: authBloc, child: NewContact());
      }),
]);
