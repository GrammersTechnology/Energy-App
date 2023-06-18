import 'package:demo/const/themes/colors.dart';
import 'package:demo/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final authController =
          Provider.of<AuthController>(context, listen: false);
      authController.cheackLocalData(context);
    });
    return Scaffold(
        body: Container(
      child: Center(
          child: Icon(
        Icons.ac_unit,
        size: 50,
        color: AppColors.primaryColor,
      )),
    ));
  }
}
