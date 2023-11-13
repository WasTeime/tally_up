import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:tally_up/src/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:tally_up/src/features/auth/presentation/pages/Test.dart';

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
  //TODO: 1) сделать чтобы изначально отображался +7 и добавить поддержку разных регионов и стран
  final _dir = 'lib/src/core/';
  final _phoneController = TextEditingController();
  final _maskFormatter = MaskTextInputFormatter(
      mask: '+7 (###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PhoneErrorMessageProvider(),
      builder: (context, child) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "${_dir}images/krug.png",
                  //fit: BoxFit.cover,
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'TALLY\nUP',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'RubikMonoOne',
                        fontSize: 50,
                        color: Color(0xFF0079FF),
                        fontWeight: FontWeight.w900,
                        height: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Введите номер телефона',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 18,
                        color: Color(0xFF0079FF),
                        fontWeight: FontWeight.w900, // regular
                        letterSpacing: -0.02, // letter spacing -2%
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      child: Selector<PhoneErrorMessageProvider, String?>(
                        selector: (_, provider) => provider.errorText,
                        builder: (_, errorMessage, __) {
                          return TextField(
                            inputFormatters: [_maskFormatter],
                            controller: _phoneController,
                            decoration: InputDecoration(
                              errorText: errorMessage,
                              contentPadding: const EdgeInsets.all(15),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(207, 203, 203, 0.989),
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                              ),
                              hintText: '+7 (000) 00-00-00',
                              hintStyle:
                                  const TextStyle(color: Color(0xFFD3E8FF)),
                            ),
                            keyboardType: TextInputType.number,
                          );
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        var validationProvider =
                            context.read<PhoneErrorMessageProvider>();
                        validationProvider
                            .getErrorMessage(_maskFormatter.getUnmaskedText());
                        if (validationProvider.phoneIsValid) {
                          context.go('/smsCodeVerify');
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF0078FE)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Продолжить',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Raleway-medium',
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500, // regular
                              letterSpacing: -0.02, // letter spacing -2%),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
