import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import '../../../../core/widgets/view.dart';
import 'ProfileEditScreen.dart';

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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 228, 236, 246),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(top: 50),
            children: <Widget>[
              Center(child: ProfilePhoto(photo: 'assets/images/events1.png')),
              const SizedBox(height: 16.0),
              UserInfoCard(
                userName: _userName,
                phoneNumber: _phoneNumber,
                email: _email,
              ),
              const SizedBox(height: 5.0),
              // Дополнительные карточки информации
              ProfileActionCard(title: 'Язык', value: 'Русский'),
              ProfileActionCard(title: 'Тема', value: 'Светлая'),
              ProfileActionCard(title: 'Мои контакты', value: '20'),
              ProfileActionCard(title: 'Мои долги', value: '3'),
              ProfileActionCard(title: 'Импорт контактов', value: 'Готово'),
              const SizedBox(height: 140.0),
              LogoutInProfileButton()
            ],
          ),
          Positioned(
            // Иконка редактирования
            top: 16,
            right: 16,
            child: IconButton(
              onPressed:
                  _navigateToEditProfilePage, // Нажатие на кнопку редактирования
              icon: const Icon(Icons.edit, color: Color(0xff0079FF), size: 30),
            ),
          ),
        ],
      ),
    );
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
        backgroundColor: Color.fromARGB(255, 218, 235, 255),
        body: Stack(
          children: [ProfilePage(), NavigIconsBar()],
        ));
  }
}
