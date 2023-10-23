import 'package:demo/features/auth/screen/splash_screen.dart';
import 'package:demo/utils/const/themes/colors.dart';
import 'package:demo/utils/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'utils/controller/local_notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().initNotification();

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
      home: const Scaffold(
        body: SplashScreen(),
      ),
    );
  }
}
