import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tally_up/src/core/layouts/mainLayout.dart';
import 'package:tally_up/src/core/widgets/view.dart';
import 'package:tally_up/src/features/profile/presentation/pages/ProfileEditScreen.dart';
import 'package:tally_up/src/features/profile/presentation/widgets/view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => __ProfileScreenState();
}

class __ProfileScreenState extends State<ProfileScreen> {
  String userName = 'Иван';
  String phoneNumber = '123-456-789';
  String email = 'example@example.com';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    List<Map<String, String>> settingsList = [
      {'name': 'Язык', 'value': 'Русский'},
      {'name': 'Тема', 'value': 'Светлая'},
      {'name': 'Мои контакты', 'value': '20'},
      {'name': 'Импорт контактов', 'value': 'Готово'},
    ];

    return MainLayout(
      appBarWidget: AppBarWidget.withEditButton(
        enableEditButton: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditProfilePage(
              username: userName,
              email: email,
            ),
          ),
        ),
      ),
      contentWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Column(
          children: [
            const ProfilePhotoWidget(),
            const ColumnGapWidget(height: 30),
            UserInfoCard(
              username: userName,
              phoneNumber: phoneNumber,
              email: email,
            ),
            const ColumnGapWidget(height: 30),
            Expanded(
              child: ListView.separated(
                itemCount: settingsList.length,
                itemBuilder: (context, index) {
                  VoidCallback? onTapEvent;
                  switch (index) {
                    case 2:
                      onTapEvent = () => context.push('/contactsAndInvitings');
                  }
                  return SettingItemCardWidget(
                    title: settingsList[index]['name'] as String,
                    value: settingsList[index]['value'] as String,
                    onTapEvent: onTapEvent,
                  );
                },
                separatorBuilder: (_, index) => const ColumnGapWidget(
                  height: 10,
                ),
              ),
            ),
            const ColumnGapWidget(),
          ],
        ),
      ),
      underContentButtonWidget: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          backgroundColor: Colors.blueAccent.shade200,
        ),
        child: Text(
          'выйти',
          style: theme.textTheme.headlineMedium?.copyWith(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
