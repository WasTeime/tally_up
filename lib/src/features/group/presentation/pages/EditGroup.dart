import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tally_up/src/core/theme.dart';
import 'package:tally_up/src/core/widgets/view.dart';
import 'package:tally_up/src/features/group/presentation/widgets/CustomEventList.dart';
import 'package:tally_up/src/features/group/presentation/widgets/EditCardGroup.dart';

class EditGroupScreen extends StatefulWidget {
  const EditGroupScreen({super.key});

  @override
  State<EditGroupScreen> createState() => _EdditGroupScreenState();
}

class _EdditGroupScreenState extends State<EditGroupScreen> {
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
        EditCardGroup(name: 'Группа Мяу', people: '5 участников'),
        CustomCardList(),
        SizedBox(
          height: 10,
        ),
        // LogoutInProfileButtonWidget(
        //   name: 'Удалить Мероприятие',
        // )
      ]),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}
