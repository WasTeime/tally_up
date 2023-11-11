import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tally_up/src/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _dir = 'lib/src/core/';
  final _phoneController = TextEditingController();
  var _phoneIsValid = false;
  final _maskFormatter = MaskTextInputFormatter(
      mask: '+7 (###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  String? get _phoneErrorMessage {
    if (_phoneController.text.isEmpty) {
      return "Введите телефон";
    } else if (_maskFormatter.getUnmaskedText().length < 10) {
      return "Введите полный номер телефона";
    }
    _phoneIsValid = true;
    return null;
  }

  @override
  void initState() {
    _phoneIsValid = false;
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  padding: const EdgeInsets.only(
                      left: 30, top: 20, right: 30, bottom: 5),
                  child: TextField(
                    inputFormatters: [_maskFormatter],
                    controller: _phoneController,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      errorText: _phoneErrorMessage,
                      contentPadding: const EdgeInsets.all(15),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
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
                      hintText: 'Телефон',
                      hintStyle: const TextStyle(color: Color(0xFFD3E8FF)),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                TextButton(
                  onPressed: null,
                  style: ButtonStyle(
                    backgroundColor: _phoneIsValid
                        ? MaterialStateProperty.all<Color>(
                            const Color(0xFF0078FE))
                        : MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 195, 195, 195)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
  }
}
