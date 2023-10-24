import 'package:demo/features/Onboarding/view/onboarding.dart';
import 'package:demo/features/auth/controller/auth_controller.dart';
import 'package:demo/utils/const/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Future.delayed(const Duration(seconds: 2)).then((value) {
        AuthController().checkOnboard();
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (ctx) => OnboardingScreen()));
      });
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
