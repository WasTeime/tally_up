import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tally_up/src/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// class _LoginScreenState extends State<LoginScreen> {
//   //TODO: 1) сделать чтобы изначально отображался +7 и добавить поддержку разных регионов и стран
//   final _dir = 'lib/src/core/';
//   final _phoneController = TextEditingController();
//   var _phoneIsValid = false;
//   final _maskFormatter = MaskTextInputFormatter(
//       mask: '+7 (###) ###-##-##',
//       filter: {"#": RegExp(r'[0-9]')},
//       type: MaskAutoCompletionType.lazy);

//   String? get _phoneErrorMessage {
//     _phoneIsValid = false;
//     if (_phoneController.text.isEmpty) return null;
//     if (_maskFormatter.getUnmaskedText().length < 10) {
//       return "Введите номер телефона";
//     }
//     _phoneIsValid = true;
//     return null;
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _phoneController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: Image.asset(
//               "${_dir}images/krug.png",
//               //fit: BoxFit.cover,
//             ),
//           ),
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'TALLY\nUP',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontFamily: 'RubikMonoOne',
//                     fontSize: 50,
//                     color: Color(0xFF0079FF),
//                     fontWeight: FontWeight.w900,
//                     height: 1,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 const Text(
//                   'Введите номер телефона',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontFamily: 'Raleway',
//                     fontSize: 18,
//                     color: Color(0xFF0079FF),
//                     fontWeight: FontWeight.w900, // regular
//                     letterSpacing: -0.02, // letter spacing -2%
//                   ),
//                 ),
//                 Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
//                   child: TextField(
//                     inputFormatters: [_maskFormatter],
//                     controller: _phoneController,
//                     onChanged: (_) => setState(() {}),
//                     decoration: InputDecoration(
//                       errorText: _phoneErrorMessage,
//                       contentPadding: const EdgeInsets.all(15),
//                       border: const OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(15)),
//                         borderSide: BorderSide(
//                           color: Color.fromRGBO(207, 203, 203, 0.989),
//                           width: 2,
//                         ),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: const BorderSide(
//                           color: Colors.blue,
//                           width: 2,
//                         ),
//                       ),
//                       hintText: '+7 (000) 00-00-00',
//                       hintStyle: const TextStyle(color: Color(0xFFD3E8FF)),
//                     ),
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: null,
//                   style: ButtonStyle(
//                     backgroundColor: _phoneIsValid
//                         ? MaterialStateProperty.all<Color>(
//                             const Color(0xFF0078FE))
//                         : MaterialStateProperty.all<Color>(
//                             Color.fromARGB(255, 195, 195, 195)),
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                   ),
//                   child: const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 10),
//                     child: Text('Продолжить',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontFamily: 'Raleway-medium',
//                           fontSize: 20,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w500, // regular
//                           letterSpacing: -0.02, // letter spacing -2%),
//                         )),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _phoneController = TextEditingController();

  late String _numberPhone;

  @override
  Widget _logo() {
    return Container(
      child: Column(children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(top: 300),
            child: Container(
              child: const Align(
                child: Text(
                  'TALLY \nUP',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'RubikMonoOne',
                    fontSize: 50,
                    color: Color(0xFF0079FF),
                    fontWeight: FontWeight.w900,
                    height: 1,
                  ),
                ),
              ),
            )),
        Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              child: const Align(
                child: Text(
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
              ),
            ))
      ]),
    );
  }

  Widget _background() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/src/core/images/krug.png"),
          //alignment: Alignment.center,
          // fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _input(String hint, TextEditingController controller, bool obscure) {
    return Container(
      padding: EdgeInsets.only(top: 450, left: 30, right: 30),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(15),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              color: Color.fromRGBO(207, 203, 203, 0.989),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Colors.blue,
              width: 3,
            ),
          ),
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFFD3E8FF)),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  void _buttonAction() {
    _numberPhone = _phoneController.text;
    _phoneController.clear();
  }

  Widget _button(void func()) {
    return Container(
      width: 180,
      height: 45,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF0078FE)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        onPressed: () {
          func();
        },
        child: const Text(
          'Продолжить',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w900, // regular
            letterSpacing: -0.02, // letter spacing -2%
          ),
        ),
      ),
    );
  }

  Widget _form(void func()) {
    return Container(
      child: Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 30, top: 10, left: 50, right: 50),
          child: _input("Телефон", _phoneController, false),
        ),
        Padding(padding: EdgeInsets.only(), child: _button(func))
      ]),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [_background(), _logo(), _form(_buttonAction)],
        ));
  }
}
