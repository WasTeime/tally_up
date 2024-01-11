import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:tally_up/src/core/widgets/view.dart';
import 'package:tally_up/src/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:tally_up/src/features/auth/presentation/widgets/view.dart';

class PinVerifyScreen extends StatefulWidget {
  const PinVerifyScreen({super.key});

  @override
  State<PinVerifyScreen> createState() => _PinVerifyScreenState();
}

class _PinVerifyScreenState extends State<PinVerifyScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          context.go('/');
        }
        if (state is SignInFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message, textAlign: TextAlign.center),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is SignInProcess) {
          return const LoadingOnWhiteBackgroundWidget();
        }
        return Scaffold(
          body: Stack(
            children: [
              BackButton(
                onPressed: () => context.go('/login'),
              ),
              const BackgroundCircleWidget(),
              _content(context),
            ],
          ),
        );
      },
    );
  }
}

Widget _content(BuildContext context) {
  String code = "";

  return Padding(
    padding: const EdgeInsets.only(top: 200, left: 20, right: 20),
    child: Column(
      children: [
        const LogoTextToAuthPageWidget('Введите код'),
        const ColumnGapWidget(),
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: Pinput(
            length: 6,
            onCompleted: (pin) => code = pin,
          ),
        ),
        const ColumnGapWidget(),
        TextButtonWidget(
          () => {context.read<SignInBloc>().add(SignIn(code))},
          "Отправить",
        ),
        const ColumnGapWidget(height: 30),
        const ResendCodeWidget(),
      ],
    ),
  );
}
