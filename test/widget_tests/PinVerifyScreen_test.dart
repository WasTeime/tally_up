import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:tally_up/src/core/theme.dart';
import 'package:tally_up/src/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:tally_up/src/features/auth/presentation/pages/PinVerifyScreen.dart';

import '../Mock.dart';

class SignInBlocMock extends Mock implements SignInBloc {}
class FirebaseMock extends Mock implements Firebase {}
class MockSignInState extends Mock implements SignInState {}
void main() {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    GetIt.I.registerLazySingleton<AppTheme>(() => AppTheme());
    await Firebase.initializeApp();
  });
  testWidgets('Проверка отображения виджета PinVerifyScreen', (WidgetTester tester) async {
    // Собираем виджет PinVerifyScreen
    final signInBloc = SignInBloc();

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<SignInBloc>.value(
          value: signInBloc,
          child: const PinVerifyScreen(),
        ),
      )
    );

    // Проверяем, что виджеты отобразились корректно
    // expect(find.byType(Pinput), findsOneWidget);
    expect(find.byType(TextButton), findsWidgets);
    expect(find.text('Отправить'), findsOneWidget);
  });

  testWidgets('Проверка взаимодействия с виджетом PinVerifyScreen', (WidgetTester tester) async {
    // final signInBloc = SignInBloc();
    // Создаем мок-блок для тестирования
    final mockSignInBloc = SignInBlocMock();
    final mockSignInState = MockSignInState();
    when(mockSignInBloc.stream).thenAnswer((_) => Stream.fromIterable([mockSignInState]));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<SignInBloc>(
          create: (context) => mockSignInBloc,
          child: const PinVerifyScreen(),
        ),
      ),
    );

    // Находим и взаимодействуем с виджетами
    await tester.enterText(find.byType(Pinput), '123456');
    await tester.tap(find.text('Отправить'));
    await tester.pumpAndSettle();

    // Производим предполагаемые проверки после взаимодействия
    verify(() => mockSignInBloc.add(const SignIn('123456'))).called(1);
  });
}
