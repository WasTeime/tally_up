import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pinput/pinput.dart';
import 'package:tally_up/src/core/theme.dart';
import 'package:tally_up/src/core/widgets/input_widgets/TextButtonWidget.dart';
import 'package:tally_up/src/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:tally_up/src/features/auth/presentation/pages/LoginScreen.dart';
import 'package:tally_up/src/features/auth/presentation/pages/PinVerifyScreen.dart';
import 'package:tally_up/src/features/auth/presentation/widgets/InputFieldWidget.dart';
import 'package:tally_up/src/features/home/presentation/pages/HomeScreen.dart';

import '../Mock.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setupFirebaseAuthMocks();

  setUpAll(() async {
    GetIt.I.registerLazySingleton<AppTheme>(() => AppTheme());
    await Firebase.initializeApp();
  });
  testWidgets('auth', (WidgetTester tester) async {
    final signInBloc = SignInBloc();

    await tester.pumpWidget(MaterialApp(
      home: BlocProvider<SignInBloc>(
        create: (context) => signInBloc,
        child: const LoginScreen(),
      ),
    ));

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.byType(PinVerifyScreen), findsNothing);

    await tester.enterText(find.byType(InputFieldWidget), '1111111111');
    await tester.pump();

    // Нажимаем кнопку "Продолжить"
    await tester.tap(find.byType(TextButtonWidget));
    await tester.pumpAndSettle();
    
    signInBloc.add(SendSmsCode as SignInEvent);

    expect(find.byType(LoginScreen), findsNothing);
    expect(find.byType(PinVerifyScreen), findsOneWidget);

    await tester.enterText(find.byType(Pinput), '111111');
    await tester.tap(find.text('Отправить'));
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);


  });
}