import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "lib/src/core/img/krug.png",
              //fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
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
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      width: 180,
                      height: 45, // Устанавливаем желаемую ширину кнопки
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF0078FE)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        onPressed: () {
                          // Обработка нажатия кнопки "Продолжить"
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
