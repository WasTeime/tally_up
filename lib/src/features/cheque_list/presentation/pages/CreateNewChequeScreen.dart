import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally_up/src/core/widgets/EnterChekWidget.dart';
import 'package:tally_up/src/core/widgets/view.dart';
import 'package:tally_up/src/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';

class CreateNewChequeScreen extends StatefulWidget {
  const CreateNewChequeScreen({super.key});

  @override
  State<CreateNewChequeScreen> createState() => _CreateNewChequeScreenState();
}

class _CreateNewChequeScreenState extends State<CreateNewChequeScreen> {
  String? get code => null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget _addCheque() {
      return Padding(
        padding: EdgeInsets.only(top: 40),
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  'Ввести чек вучную',
                  style: theme.textTheme.headlineMedium
                      ?.copyWith(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const ColumnGapWidget(),
                Container(
                  height: 395,
                  width: 400,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 48,
                        offset: Offset(4, 8),
                      ),
                    ],
                  ),
                  child: const Form(
                      child: Column(
                    children: [
                      EnterChekWidget(
                          label: "Дата:", hint: "Введите дату чека"),
                      Divider(),
                      EnterChekWidget(
                          label: "Время:", hint: "Введите время чека"),
                      Divider(),
                      EnterChekWidget(
                          label: "Итого:", hint: "Введите сумму чека"),
                      Divider(),
                      EnterChekWidget(label: "ФН№:", hint: "Введите ФН№ чека"),
                      Divider(),
                      EnterChekWidget(label: "ФД№:", hint: "Введите ФД№ чека"),
                      Divider(),
                      EnterChekWidget(label: "ФПД:", hint: "Введите ФПД чека"),
                    ],
                  )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 200),
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
