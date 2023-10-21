import 'package:demo/features/Onboarding/view/onboarding.dart';
import 'package:demo/features/auth/controller/auth_controller.dart';
import 'package:demo/features/navbar_widget.dart';
import 'package:demo/utils/const/themes/colors.dart';
import 'package:demo/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(authControllerProvider);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (controller.isOnboardingCompleted == false) {
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
