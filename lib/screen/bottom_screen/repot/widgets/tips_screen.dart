import 'package:demo/const/space_helper.dart';
import 'package:demo/const/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../controller/profile_controller.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: savingTips.isNotEmpty
            ? ListView.separated(
                padding: EdgeInsets.all(10),
                separatorBuilder: (context, index) {
                  return vSpaceRegular;
                },
                itemCount: savingTips.length,
                itemBuilder: (context, index) {
                  return Container(
                      padding: EdgeInsets.all(8),
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
                              savingTips[index].savingstips,
                              style: GoogleFonts.nunitoSans(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                      ));
                })
            : Center(
                child: Text("Tips not available"),
              ),
      ),
    );
  }
}
