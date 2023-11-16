import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:tally_up/src/core/widgets/view.dart';
import 'package:tally_up/src/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:tally_up/src/features/auth/presentation/widgets/view.dart';

class PinVerifyScreen extends StatefulWidget {
  const PinVerifyScreen({super.key});

  @override
  State<PinVerifyScreen> createState() => _PinVerifyScreenState();
}

class _PinVerifyScreenState extends State<PinVerifyScreen> {
  String code = "";

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          context.go('/');
        }
        if (state is SignInFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message, textAlign: TextAlign.center),
              backgroundColor: Colors.red));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: () => context.go('/login')),
        ),
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          const BackgroundCircleWidget(),
          Padding(
            padding: const EdgeInsets.only(top: 200, left: 20, right: 20),
            child: Column(
              children: <Widget>[
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
                    "Отправить"),
                const ColumnGapWidget(height: 30),
                const ResendCodeWidget(),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
