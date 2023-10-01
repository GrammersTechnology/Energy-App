import 'package:demo/const/themes/colors.dart';
import 'package:flutter/material.dart';

import '../../riverpod/controller/auth_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AuthController().cheackLocalData(context);
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
