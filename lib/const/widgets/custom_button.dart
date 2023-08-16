import 'package:demo/const/themes/text.dart';
import 'package:flutter/material.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget(
      {super.key, required this.title, required this.onTap});
  final String title;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 37, 126, 198),
              Color.fromARGB(255, 3, 83, 149),
              // Color.fromARGB(255, 37, 126, 198)
            ]),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Center(
            child: Text(
          title,
          style: AppText.whiteTextStyle,
        )),
      ),
    );
  }
}
