import 'package:demo/auth/screen/loginscreen.dart';
import 'package:demo/const/space_helper.dart';
import 'package:demo/const/themes/colors.dart';
import 'package:demo/controller/auth_controller.dart';
import 'package:demo/controller/profile_controller.dart';
import 'package:demo/screen/bottom_screen/repot/widgets/tips_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../controller/home_controller.dart';
import '../../../controller/local_notification.dart';
import '../../../routes/routes.dart';
import '../home/widget/custom_graphwidget.dart';

class ReoprtScreen extends StatelessWidget {
  const ReoprtScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context, listen: false);
    final controller = Provider.of<HomeController>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getTips(context);
    });
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: GestureDetector(
          onTap: () {},
          child: Text(
            'Strompris',
            style: GoogleFonts.montserrat(
                fontSize: 25, fontWeight: FontWeight.w500),
          ),
        ),
        actions: [
          GestureDetector(
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.logout),
            ),
            onTap: () {
              authController.signout(context);
              authController.clearLocalData();
              Routes.pushreplace(screen: const LoginScreen());
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return controller.getTips(context);
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                vSpaceMin,
                Text(
                  'Price Predictor',
                  style: GoogleFonts.montserrat(
                      fontSize: 25, fontWeight: FontWeight.w500),
                ),
                vSpaceMedium,
                const ColumnGraphWidget(),
                vSpaceRegular,
                Text(
                  'Price Graph',
                  style: GoogleFonts.montserrat(
                      fontSize: 25, fontWeight: FontWeight.w500),
                ),
                vSpaceRegular,
                const StepperGraphWidget(),
                vSpaceMedium,
                Text(
                  'Savings Tips',
                  style: GoogleFonts.montserrat(
                      fontSize: 25, fontWeight: FontWeight.w500),
                ),
                vSpaceRegular,
                savingTips.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(right: 16, left: 16),
                        child: Container(
                            // height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8, top: 8),
                                  child: Text(
                                    savingTips.first.savingstips,
                                    style: GoogleFonts.nunitoSans(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Routes.push(
                                              screen: const TipsScreen());
                                        },
                                        child: const Text(
                                          'Read more',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        )),
                                  ],
                                )
                              ],
                            )),
                      )
                    : const Text("Savings Tips Not Available"),
                vSpaceXl
              ],
            ),
          ),
        ),
      ),
    );
  }
}
