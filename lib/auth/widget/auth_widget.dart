import 'package:demo/auth/screen/loginscreen.dart';
import 'package:demo/const/space_helper.dart';
import 'package:flutter/material.dart';

import '../../const/themes/colors.dart';
import '../../const/themes/text.dart';

class AuthContainerWidget extends StatelessWidget {
  AuthContainerWidget({super.key, required this.size, required this.title});

  final Size size;
  String title;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurveClipper(),
      child: Container(
          width: double.infinity,
          height: size.height / 2.8,
          color: AppColors.primaryColor,
          child: Column(
            children: [
              vSpaceXl,
              vSpaceXl,
              Icon(
                Icons.ac_unit,
                color: Colors.white,
                size: 60,
              ),
              vSpaceXl,
              Row(
                children: [
                  Spacer(),
                  Text(title, style: AppText.whiteTextStyle),
                  hSpaceMedium
                ],
              )
            ],
          )),
    );
  }
}
