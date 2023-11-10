import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tally_up/src/core/firebase_options.dart';
import 'package:tally_up/src/core/theme.dart';

void main() async {
  GetIt.I.registerSingleton(AppTheme());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const TallyUp());
}

class TallyUp extends StatelessWidget {
  const TallyUp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: GetIt.I<AppTheme>().currentTheme);
  }
}
