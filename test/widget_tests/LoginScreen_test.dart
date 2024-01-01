import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:tally_up/src/core/theme.dart';
import 'package:tally_up/src/core/widgets/view.dart';
import 'package:tally_up/src/features/auth/presentation/widgets/InputFieldWidget.dart';
import 'package:tally_up/src/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:tally_up/src/features/auth/presentation/pages/LoginScreen.dart';

import '../Mock.dart';

class PhoneErrorMessageProviderMock extends Mock
    implements PhoneErrorMessageProvider {}

class FirebaseMock extends Mock implements Firebase {}

void main() {
  group('Validate phone number', () {
    test('validatePhoneNumber возвращает ошибку для неполного номера телефона',
        () {
      final provider = PhoneErrorMessageProvider();
      provider.getErrorMessage('12345');
      expect(provider.errorText, equals('Введите полный номер телефона'));
    });

    test('validatePhoneNumber возвращает ошибку для пустого номера телефона',
        () {
      final provider = PhoneErrorMessageProvider();
      provider.getErrorMessage('');
      expect(provider.errorText, equals('Вы не ввели номер телефона'));
    });

    test(
        'validatePhoneNumber не возвращает ошибку для корректного номера телефона',
        () {
      final provider = PhoneErrorMessageProvider();
      provider.getErrorMessage('1234567890');
      expect(provider.errorText, isNull);
    });
  });

  // test('Маска генерирует верный формат номера телефона', () {
  //   final phoneController = TextEditingController(text: '9012705806');
  //   final maskFormatter = MaskTextInputFormatter(
  //     mask: '+7 (###) ###-##-##',
  //     filter: {"#": RegExp(r'[0-9]')},
  //     type: MaskAutoCompletionType.lazy);
  //   // const unmaskedText = '9012705806';
  //   final maskedText = maskFormatter.getMaskedText();
  //   expect(maskedText, equals("+7 (901) 270-58-06"));
  // });

  group('Widget tests', () {
    setupFirebaseAuthMocks();

    setUpAll(() async {
      GetIt.I.registerLazySingleton<AppTheme>(() => AppTheme());
      await Firebase.initializeApp();
    });
    testWidgets('Проверка корректного отображения виджетов в LoginScreen',
        (WidgetTester tester) async {
      final signInBloc = SignInBloc();

      await tester.pumpWidget(MaterialApp(
        home: BlocProvider<SignInBloc>.value(
          value: signInBloc,
          child: const LoginScreen(),
        ),
      ));
      // await tester.pumpAndSettle();
      expect(find.text('Введите телефон'),
          findsOneWidget); // Проверяем отображение текста "Введите телефон"
      expect(find.byType(InputFieldWidget),
          findsOneWidget); // Проверяем наличие InputFieldWidget
      expect(find.byType(TextButtonWidget),
          findsWidgets); // Проверяем наличие TextButtonWidget
    });

    testWidgets(
        'Проверка взаимодействия с некорректным вводом телефонного номера в LoginScreen',
        (WidgetTester tester) async {
      final signInBloc = SignInBloc();

      await tester.pumpWidget(MaterialApp(
        home: BlocProvider<SignInBloc>.value(
          value: signInBloc,
          child: const LoginScreen(),
        ),
      ));

      // Передаем некорректный номер телефона (слишком короткий)
      await tester.enterText(find.byType(InputFieldWidget), '123');
      await tester.pump();

      // Нажимаем кнопку "Продолжить"
      await tester.tap(find.byType(TextButtonWidget));
      await tester.pump();

      // Проверяем, что при некорректном номере телефона появилось сообщение об ошибке
      expect(find.text('Введите полный номер телефона'), findsOneWidget);
    });

    testWidgets(
        'Проверка взаимодействия с пустым вводом телефонного номера в LoginScreen',
        (WidgetTester tester) async {
      final signInBloc = SignInBloc();

      await tester.pumpWidget(MaterialApp(
        home: BlocProvider<SignInBloc>.value(
          value: signInBloc,
          child: const LoginScreen(),
        ),
      ));

      // Нажимаем кнопку "Продолжить"
      await tester.tap(find.byType(TextButtonWidget));
      await tester.pump();

      // Проверяем, что при некорректном номере телефона появилось сообщение об ошибке
      expect(find.text('Вы не ввели номер телефона'), findsOneWidget);
    });

    testWidgets(
        'Проверка взаимодействия с вводом и валидацией телефонного номера в LoginScreen',
        (WidgetTester tester) async {
      final signInBloc = SignInBloc();

      await tester.pumpWidget(MaterialApp(
        home: BlocProvider<SignInBloc>.value(
          value: signInBloc,
          child: const LoginScreen(),
        ),
      ));

      // Передаем корректный номер телефона
      await tester.enterText(find.byType(InputFieldWidget), '1234567890');
      await tester.pump();

      // Нажимаем кнопку "Продолжить"
      await tester.tap(find.byType(TextButtonWidget));
      await tester.pump();

      // Проверяем, что при корректном номере телефона произошла попытка отправки SMS кода
      expect(find.byType(SignInBloc), findsOneWidget);
    });
  });
}
