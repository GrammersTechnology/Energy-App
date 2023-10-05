import 'package:demo/utils/const/space_helper.dart';
import 'package:demo/features/auth/screen/loginscreen.dart';
import 'package:flutter/material.dart';

import '../../../utils/const/themes/colors.dart';
import '../../../utils/const/themes/text.dart';

class AuthContainerWidget extends StatelessWidget {
  const AuthContainerWidget(
      {super.key, required this.size, required this.title});

  final Size size;
  final String title;

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
              const Icon(
                Icons.ac_unit,
                color: Colors.white,
                size: 60,
              ),
              vSpaceXl,
              Row(
                children: [
                  const Spacer(),
                  Text(title, style: AppText.whiteTextStyle),
                  hSpaceMedium
                ],
              )
            ],
          )),
    );
  }
}