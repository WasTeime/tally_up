import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tally_up/src/core/firebase_options.dart';
import 'package:tally_up/src/core/theme.dart';
import 'package:tally_up/src/core/router.dart';

void main() async {
  GetIt.I.registerSingleton(AppTheme());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(const TallyUp());
}

class TallyUp extends StatelessWidget {
  const TallyUp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: GetIt.I<AppTheme>().currentTheme,
      routerConfig: router,
    );
  }
}
