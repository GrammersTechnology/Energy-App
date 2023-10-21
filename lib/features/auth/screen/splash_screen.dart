import 'package:demo/features/Onboarding/view/onboarding.dart';
import 'package:demo/features/navbar_widget.dart';
import 'package:demo/utils/const/themes/colors.dart';
import 'package:demo/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final pref = await SharedPreferences.getInstance();
      if (pref.getBool('finishedOnboarding') == false) {
        Future.delayed(const Duration(seconds: 2)).then((value) =>
            Routes.pushRemoveUntil(screen: const OnboardingScreen()));
      } else {
        Future.delayed(const Duration(seconds: 2)).then(
            (value) => Routes.pushRemoveUntil(screen: const NavBarWidget()));
      }
    });
    return const Scaffold(
        body: Center(
            child: Icon(
      Icons.ac_unit,
      size: 50,
      color: AppColors.primaryColor,
    )));
  }
}
