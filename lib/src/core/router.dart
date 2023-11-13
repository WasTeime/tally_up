import 'package:go_router/go_router.dart';
import 'package:tally_up/src/features/auth/presentation/pages/HomePage.dart';
import 'package:tally_up/src/features/auth/presentation/pages/LoginScreen.dart';
import 'package:tally_up/src/features/auth/presentation/pages/Test.dart';

final router = GoRouter(initialLocation: '/login', routes: [
  GoRoute(path: '/', builder: (context, state) => HomePage()),
  GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
  GoRoute(path: '/smsCodeVerify', builder: (context, state) => TestPage())
]);
