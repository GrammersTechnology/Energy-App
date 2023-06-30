import 'package:csv/csv.dart';
import 'package:demo/controller/auth_controller.dart';
import 'package:demo/routes/routes.dart';
import 'package:demo/screen/bottom_screen/profile/widget/profile_edit_screen.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../../../const/themes/colors.dart';
import '../../../../const/themes/text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Jenny Wilson',
          style: AppText.blackTextStyle.copyWith(
            fontSize: 18,
            fontWeight: AppText.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              size: 24,
            ),
            color: AppColors.blackColor,
            onPressed: () {
              AuthController().addUserProfileDetails(context);
              // Routes.push(screen: ProfileEditScreen());
            },
          ),
          SizedBox(width: 24),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(right: 24, left: 24, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildImageProfile(),
                const SizedBox(height: 16),
                const SizedBox(height: 24),
                _buildDescription(
                  "2",
                  "Power Company",
                  " 5",
                  "Price zone",
                  "5",
                  "Yearly cosumption",
                ),
                const SizedBox(height: 24),
                _buildDescription(
                  "2",
                  "Has sensor",
                  " 5",
                  "Has el car",
                  "5",
                  "Has eat pump",
                ),
                const SizedBox(height: 24),
                _buildDescription(
                  "2",
                  "Has solar panel",
                  " 5",
                  "Number of pepole",
                  "5",
                  "Want PushWarning1",
                ),
                const SizedBox(height: 24),
                _buildDescription(
                  "5",
                  "Want PushWarning2",
                  "2",
                  "PowerPoint",
                  " 5",
                  "PowerCoins",
                ),
                const SizedBox(height: 24),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildImageProfile() {
    return Container(
      width: 130,
      height: 130,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.dashedLineColor,
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: Image.network(
          'https://static.vecteezy.com/system/resources/previews/019/896/008/original/male-user-avatar-icon-in-flat-design-style-person-signs-illustration-png.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Row _buildDescription(
    rowOneContent,
    rowOneHead,
    rowTwoContent,
    rowTwoHead,
    rowThreeContent,
    rowThreeHead,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                rowOneContent,
                style: AppText.blackTextStyle.copyWith(
                  fontWeight: AppText.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              FittedBox(
                child: Text(
                  rowOneHead,
                  style: AppText.blackTextStyle.copyWith(
                    fontWeight: AppText.regular,
                    color: AppColors.greyColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                rowTwoContent,
                style: AppText.blackTextStyle.copyWith(
                  fontWeight: AppText.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              FittedBox(
                child: Text(
                  rowTwoHead,
                  style: AppText.blackTextStyle.copyWith(
                    fontWeight: AppText.regular,
                    color: AppColors.greyColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                rowThreeContent,
                style: AppText.blackTextStyle.copyWith(
                  fontWeight: AppText.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              FittedBox(
                child: Text(
                  rowThreeHead,
                  style: AppText.blackTextStyle.copyWith(
                    fontWeight: AppText.regular,
                    color: AppColors.greyColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // physics: const BouncingScrollPhysics(),
}
