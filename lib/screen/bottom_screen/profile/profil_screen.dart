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
        actions: const [
          Icon(
            Icons.more_horiz_rounded,
            size: 24,
            color: AppColors.blackColor,
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
                Text(
                  "User",
                  style: AppText.blackTextStyle.copyWith(
                    fontWeight: AppText.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 24),
                _buildDescription(),
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

  Row _buildDescription() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "29",
              style: AppText.blackTextStyle.copyWith(
                fontWeight: AppText.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Following",
              style: AppText.blackTextStyle.copyWith(
                fontWeight: AppText.regular,
                color: AppColors.greyColor,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "121.9k",
              style: AppText.blackTextStyle.copyWith(
                fontWeight: AppText.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Followers",
              style: AppText.blackTextStyle.copyWith(
                fontWeight: AppText.regular,
                color: AppColors.greyColor,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "7.5M",
              style: AppText.blackTextStyle.copyWith(
                fontWeight: AppText.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Likes",
              style: AppText.blackTextStyle.copyWith(
                fontWeight: AppText.regular,
                color: AppColors.greyColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row _buildButtonAction() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.greenColor,
            minimumSize: const Size(120, 45),
            elevation: 8,
            shadowColor: AppColors.primaryColor.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text('Follow',
              style: AppText.whiteTextStyle
                  .copyWith(fontWeight: AppText.semiBold)),
        ),
        const SizedBox(width: 12),
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.greyColor.withOpacity(0.17),
            image: const DecorationImage(
              scale: 2.3,
              image: AssetImage("assets/images/ic_inbox.png"),
            ),
          ),
        )
      ],
    );
  }

  Row _buildTabBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Photos",
          style: AppText.blackTextStyle.copyWith(
            fontWeight: AppText.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(width: 24),
        Text(
          "Video",
          style: AppText.blackTextStyle.copyWith(
            fontWeight: AppText.bold,
            fontSize: 18,
            color: AppColors.greyColor,
          ),
        ),
        const SizedBox(width: 24),
        Text(
          "Tagged",
          style: AppText.blackTextStyle.copyWith(
            fontWeight: AppText.bold,
            fontSize: 18,
            color: AppColors.greyColor,
          ),
        ),
        const SizedBox(width: 24),
        // const Spacer(),
        Text(
          "All",
          style: AppText.blackTextStyle.copyWith(
            fontWeight: AppText.bold,
            fontSize: 18,
            color: AppColors.greyColor,
          ),
        ),
        // Image.asset("assets/images/ic_dots_2.png", width: 32),
      ],
    );
  }
  // physics: const BouncingScrollPhysics(),

  _buildGridList(BuildContext context) {
    return SizedBox(
      height: 400,
      width: double.infinity,
      child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 6,
          mainAxisSpacing: 6,
          childAspectRatio: 0.62,
          physics: const BouncingScrollPhysics(),
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    image: const DecorationImage(
                      image: NetworkImage(
                        " gallery.imageggggggg",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 10,
                  ),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    "gallery.like",
                    style: AppText.blackTextStyle
                        .copyWith(fontWeight: AppText.bold, fontSize: 10),
                  ),
                ),
              ],
            )
          ]),
    );
  }
}
