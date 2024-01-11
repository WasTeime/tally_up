import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tally_up/src/core/theme.dart';
import 'package:tally_up/src/core/widgets/view.dart';
import 'package:tally_up/src/features/auth/presentation/widgets/view.dart';
import 'package:tally_up/src/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';

class LoginScreen extends StatelessWidget {
  final phoneController = TextEditingController();
  final phoneFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  final theme = GetIt.I<AppTheme>().currentTheme;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const AuthBackgroundWidget(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LogoTextToAuthPageWidget("Введите телефон"),
                const ColumnGapWidget(),
                Form(
                  key: formKey,
                  child: InputWidget(
                    hintText: "+7 (000) 00-00-00",
                    inputController: phoneController,
                    inputFormatters: [phoneFormatter],
                    keyboardType: TextInputType.phone,
                    formValidationEvent: (phone) {
                      if (phone == null || phone.isEmpty) {
                        return "Введите номер телефона";
                      } else if (phone.length < 10) {
                        return "Введите полный номер";
                      }
                      return null;
                    },
                    autofocus: true,
                  ),
                ),
                const ColumnGapWidget(height: 30),
                TextButtonWidget(
                  () {
                    if (formKey.currentState!.validate()) {
                      context.read<SignInBloc>().phone =
                          phoneFormatter.getUnmaskedText();
                      context.read<SignInBloc>().add(SendSmsCode());
                    }
                  },
                  "Продолжить",
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
