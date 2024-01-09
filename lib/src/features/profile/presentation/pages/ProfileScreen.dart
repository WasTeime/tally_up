import 'package:flutter/material.dart';
import 'package:tally_up/src/core/widgets/view.dart';
import 'package:tally_up/src/features/profile/presentation/pages/ProfileEditScreen.dart';
import 'package:tally_up/src/features/profile/presentation/widgets/view.dart';

import '../../../../core/layouts/mainLayout.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _userName = 'Иван';
  String _phoneNumber = '123-456-789';
  String _email = 'example@example.com';

  void _navigateToEditProfilePage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
          userName: _userName,
          phoneNumber: _phoneNumber,
          email: _email,
        ),
      ),
    );

    if (result == true) {
      // Обновляем информацию пользователя, если были сохранены изменения
      setState(() {
        // Обновляем состояние с учётом нового имени
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appBarWidget = AppBarWidget.onlyEdit(enableEditButton: () {
      _navigateToEditProfilePage();
    });
    return MainLayout(
        appBarWidget: appBarWidget,
        contentWidget: Stack(
          children: [
            ListView(
              children: <Widget>[
                Center(child: ProfilePhoto(photo: 'assets/images/events1.png')),
                const SizedBox(height: 16.0),
                UserInfoCard(
                  userName: _userName,
                  phoneNumber: _phoneNumber,
                  email: _email,
                ),
                const SizedBox(height: 5.0),
                ProfileActionCard(title: 'Язык', value: 'Русский'),
                ProfileActionCard(title: 'Тема', value: 'Светлая'),
                ProfileActionCard(title: 'Мои контакты', value: '20'),
                ProfileActionCard(title: 'Мои долги', value: '3'),
                ProfileActionCard(title: 'Импорт контактов', value: 'Готово'),
                SizedBox(height: 40.0),
                LogoutInProfileButtonWidget(name: "Выход"),
              ],
            ),
          ],
        ),
        underContentButtonWidget: LogoutInProfileButtonWidget(name: "Выход"));
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => __ProfileScreenState();
}

class __ProfileScreenState extends State<ProfileScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [ProfilePage()],
      ),
    );
  }
}
