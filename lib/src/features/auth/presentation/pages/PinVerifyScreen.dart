import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:tally_up/src/core/widgets/view.dart';
import 'package:tally_up/src/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:tally_up/src/features/auth/presentation/widgets/view.dart';

class PinVerifyScreen extends StatelessWidget {
  const PinVerifyScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String code = "";

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
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              SafeArea(
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  iconSize: 35,
                  onPressed: () => context.pop(),
                ),
              ),
              const AuthBackgroundWidget(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LogoTextToAuthPageWidget('Введите код'),
                  const ColumnGapWidget(),
                  Pinput(
                    length: 6,
                    onCompleted: (pin) => code = pin,
                  ),
                  const ColumnGapWidget(height: 50),
                  TextButtonWidget(
                    () => {context.read<SignInBloc>().add(SignIn(code))},
                    "Отправить",
                  ),
                  const ColumnGapWidget(height: 30),
                  const ResendCodeWidget(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
