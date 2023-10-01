import 'package:demo/riverpod/controller/profile_controller.dart';
import 'package:demo/riverpod/provider.dart';
import 'package:demo/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../const/themes/colors.dart';
import '../../../const/themes/text.dart';
import '../widget/profile_edit_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ProfileController().getUserProfileDetails();
    });

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            userProfile?.name ?? "Unknow Name",
            style: AppText.blackTextStyle.copyWith(
              fontSize: 18,
              fontWeight: AppText.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.edit,
                size: 24,
              ),
              color: AppColors.blackColor,
              onPressed: () {
                // ProfileController()
                //     .addUserProfileDetails(true, true, true, true, true, true);
                Routes.push(screen: const ProfileEditScreen());
              },
            ),
            const SizedBox(width: 24),
          ],
        ),
        body: ref.watch(profileProvider).when(
          data: (data) {
            return SafeArea(
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
                        data?.powerCompany.toString(),
                        "Power Company",
                        data?.pricezone.toString(),
                        "Price zone",
                        data?.yearlyCosumption.toString(),
                        "Yearly cosumption",
                      ),
                      const SizedBox(height: 24),
                      _buildDescription(
                        data?.hasSensor.toString(),
                        "Has sensor",
                        data?.hasElCar.toString(),
                        "Has el car",
                        data?.hasEatPump.toString(),
                        "Has eat pump",
                      ),
                      const SizedBox(height: 24),
                      _buildDescription(
                        data?.hasSolarPanel.toString(),
                        "Has solar panel",
                        data?.numberOfPepole.toString(),
                        "Number of pepole",
                        data?.wantPushWarning1.toString(),
                        "Want PushWarning1",
                      ),
                      const SizedBox(height: 24),
                      _buildDescription(
                        data?.wantPushWarning2.toString(),
                        "Want PushWarning2",
                        data?.powerPoint.toString(),
                        "PowerPoint",
                        data?.powerCoins.toString(),
                        "PowerCoins",
                      ),
                      const SizedBox(height: 24),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            );
          },
          error: (error, stackTrace) {
            return Text("data");
          },
          loading: () {
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
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
    String rowOneHead,
    rowTwoContent,
    String rowTwoHead,
    rowThreeContent,
    String rowThreeHead,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                height: 30,
                child: FittedBox(
                  child: Text(
                    rowOneContent,
                    style: AppText.blackTextStyle.copyWith(
                      fontWeight: AppText.bold,
                      fontSize: 16,
                    ),
                  ),
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
