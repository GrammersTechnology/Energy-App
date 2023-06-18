// font weight

import 'package:demo/const/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText {
  static FontWeight light = FontWeight.w300;
  static FontWeight regular = FontWeight.w400;
  static FontWeight medium = FontWeight.w500;
  static FontWeight semiBold = FontWeight.w600;
  static FontWeight bold = FontWeight.w700;
  static FontWeight extraBold = FontWeight.w800;
  static FontWeight black = FontWeight.w900;

  // text Style
  static final TextStyle lightText = GoogleFonts.poppins(
    color: AppColors.blackTextColor,
  );

  static TextStyle blackTextStyle = GoogleFonts.poppins(
    color: AppColors.blackTextColor,
  );
  static TextStyle whiteTextStyle = GoogleFonts.poppins(
      color: AppColors.whiteColor, fontSize: 18, fontWeight: FontWeight.w600);
  static TextStyle greyTextStyle = GoogleFonts.poppins(
    color: AppColors.greyTextColor,
  );
}
