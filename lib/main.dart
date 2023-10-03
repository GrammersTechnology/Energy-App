import 'package:demo/const/themes/colors.dart';
import 'package:demo/utils/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controller/local_notification.dart';
import 'riverpod/auth/screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().initNotification();
  NotificationService().showNotification();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Routes.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: AppColors.primaryColor),
      home: const SplashScreen(),
    );
  }
}
