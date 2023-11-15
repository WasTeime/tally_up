import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:tally_up/src/core/theme.dart';
import 'package:tally_up/src/core/widgets/view.dart';
import 'package:tally_up/src/features/auth/presentation/widgets/view.dart';
import 'package:tally_up/src/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class PhoneErrorMessageProvider extends ChangeNotifier {
  String? errorText;

  get phoneIsValid {
    return errorText == null;
  }

  void getErrorMessage(String phone) {
    if (phone.isEmpty) {
      errorText = "Вы не ввели номер телефона";
    } else if (phone.length < 10) {
      errorText = "Введите полный номер телефона";
    } else {
      errorText = null;
    }
    notifyListeners();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  //TODO: походу надо переменной не в state объявлять, а в классе виджета
  //functional
  final _phoneController = TextEditingController();
  final _maskFormatter = MaskTextInputFormatter(
      mask: '+7 (###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  final theme = GetIt.I<AppTheme>().currentTheme;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
  //end functional

  //widgets
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PhoneErrorMessageProvider(),
      builder: (context, child) {
        return BlocListener<SignInBloc, SignInState>(
          listener: (context, state) {
            if (state is SendSmsCodeSuccess) {
              context.go('/smsCodeVerify');
            }
          },
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Stack(
                children: [
                  const BackgroundCircleWidget(),
                  _contentWrapper(context)
                ],
              )),
        );
      },
    );
  }

  Widget _contentWrapper(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 200, left: 30, right: 30),
      child: Column(children: [
        const LogoTextToAuthPageWidget("Введите телефон"),
        const ColumnGapWidget(),
        Selector<PhoneErrorMessageProvider, String?>(
            selector: (_, provider) => provider.errorText,
            builder: (_, errorMessage, __) {
              return InputFieldWidget(
                "+7 (000) 00-00-00",
                _phoneController,
                errorMessage: errorMessage,
                inputFormatters: [_maskFormatter],
              );
            }),
        const ColumnGapWidget(),
        TextButtonWidget(() {
          var validationProvider = context.read<PhoneErrorMessageProvider>();
          validationProvider.getErrorMessage(_maskFormatter.getUnmaskedText());
          if (validationProvider.phoneIsValid) {
            context
                .read<SignInBloc>()
                .setPhone("+7${_maskFormatter.getUnmaskedText()}");
            context.read<SignInBloc>().add(SendSmsCode());
          }
        }, "Продолжить")
      ]),
    );
  }
  //end widgets
}
