import 'package:demo/auth/screen/splash_screen.dart';
import 'package:demo/const/themes/colors.dart';
import 'package:demo/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/auth_controller.dart';
import 'controller/chartcontroller.dart';
import 'controller/home_controller.dart';
import 'controller/hva_kaster_controller.dart';
import 'controller/local_notification.dart';
import 'controller/profile_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().initNotification();
  NotificationService().showNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthController>(create: (_) => AuthController()),
        ChangeNotifierProvider<HomeController>(create: (_) => HomeController()),
        ChangeNotifierProvider<ChartController>(
            create: (_) => ChartController()),
        ChangeNotifierProvider<ProfileController>(
            create: (_) => ProfileController()),
        ChangeNotifierProvider<HvaController>(create: (_) => HvaController()),
      ],
      child: MaterialApp(
        navigatorKey: Routes.navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: AppColors.primaryColor),
        home: const SplashScreen(),
      ),
    );
  }
}
