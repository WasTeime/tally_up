import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tally_up/src/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:tally_up/src/features/auth/presentation/pages/HomePage.dart';
import 'package:tally_up/src/features/auth/presentation/pages/LoginScreen.dart';
import 'package:tally_up/src/features/auth/presentation/pages/PinVerifyScreen.dart';

final authBloc = SignInBloc();

final router = GoRouter(initialLocation: '/login', routes: [
  GoRoute(path: '/', builder: (context, state) => const HomePage()),
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
]);
