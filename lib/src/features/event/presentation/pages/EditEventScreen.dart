import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:tally_up/src/core/widgets/view.dart';
import 'package:tally_up/src/features/event/presentation/widgets/EditCardEvent.dart';

import '../../../../core/theme.dart';
import '../../../profile/presentation/widgets/view.dart';
import '../widgets/view.dart';

class CheckListEditScreen extends StatefulWidget {
  const CheckListEditScreen({super.key});

  @override
  State<CheckListEditScreen> createState() => _CheckListEditScreenState();
}

class _CheckListEditScreenState extends State<CheckListEditScreen> {
  Widget _chequeList() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: SizedBox(
        height: 510,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                childAspectRatio: 3 / 2,
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
                maxCrossAxisExtent: 200),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {},
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            blurRadius: 10,
                            offset: const Offset(4, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage('assets/images/cheque.png'),
                                  width: 40,
                                  height: 40,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Номер чека $index'), // Номер чека
                                const Text('Сумма чека'), // Сумма чека в рублях
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () {
                          // Действие при нажатии
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = GetIt.I<AppTheme>().currentTheme;
    final color = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBarForEditScreen(color: color, name: 'Редактировать'),
      ),
      backgroundColor: const Color.fromARGB(255, 218, 235, 255),
      body: Column(children: [
        const EditCardEvent(name: 'Мероприятие Мяу', people: '5 участников'),
        DateListChequeWidget(
            date: DateFormat('yyyy-MM-dd').format(DateTime(2002, 10, 10))),
        _chequeList(),
        const SizedBox(
          height: 20,
        ),
        const LogoutInProfileButtonWidget(
          name: 'Удалить чек',
        )
      ]),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}
