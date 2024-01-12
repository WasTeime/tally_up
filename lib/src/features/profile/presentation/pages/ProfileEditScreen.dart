import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tally_up/src/core/layouts/mainLayout.dart';
import 'package:tally_up/src/core/widgets/view.dart';
import 'package:tally_up/src/features/profile/presentation/widgets/ProfilePhotoEditWidget.dart';
import 'package:tally_up/src/features/profile/presentation/widgets/view.dart';

class EditProfilePage extends StatelessWidget {
  final String? username;
  final String? email;

  const EditProfilePage({
    super.key,
    this.username,
    this.email,
  });

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBarWidget: AppBarWidget.withAcceptButton(
        enableAcceptButton: () => {
          //здесь нужно сохранять дату в бд (через bloc)
          context.pop()
        },
        enableBackButton: () => context.pop(),
      ),
      contentWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Column(
          children: [
            const ProfilePhotoEditWidget(),
            const ColumnGapWidget(height: 50),
            UserInfoCardEditable(title: 'имя', value: username),
            const ColumnGapWidget(),
            UserInfoCardEditable(title: 'почта', value: email),
          ],
        ),
      ),
    );
  }
}
