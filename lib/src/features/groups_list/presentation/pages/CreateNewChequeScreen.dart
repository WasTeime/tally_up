import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally_up/src/core/widgets/EnterChek.dart';
import 'package:tally_up/src/core/widgets/view.dart';
import 'package:tally_up/src/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';

class CreateNewChequeScreen extends StatefulWidget {
  const CreateNewChequeScreen({super.key});

  @override
  State<CreateNewChequeScreen> createState() => _CreateNewChequeScreenState();
}

class _CreateNewChequeScreenState extends State<CreateNewChequeScreen> {
  String? get code => null;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final TextEditingController inputController = TextEditingController();
    Widget _addCheque() {
      return Padding(
        padding: EdgeInsets.only(top: 40),
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              children: [
                Text(
                  'Ввести чек вручную',
                  style: theme.textTheme.headlineLarge,
                ),
                const ColumnGapWidget(),
                Container(
                  height: 338,
                  width: 300,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 4,
                        offset: Offset(4, 8),
                      ),
                    ],
                  ),
                  child: const Form(
                      child: Column(
                    children: [
                      EnterChek(label: "Дата:"),
                      EnterChek(label: "Время:"),
                      EnterChek(label: "Сумма:"),
                      EnterChek(label: "ФН№:"),
                      EnterChek(label: "ФД№:"),
                      EnterChek(label: "ФПД:"),
                    ],
                  )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 250),
                  child: TextButtonWidget(
                      () => {context.read<SignInBloc>().add(SignIn(code!))},
                      "Продолжить"),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 218, 235, 255),
      body: Stack(
        children: [
          _addCheque(),
          NavigIconsBar(),
        ],
      ),
    );
  }
}
