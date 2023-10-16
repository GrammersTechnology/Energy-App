// ignore_for_file: must_be_immutable

import 'package:demo/utils/const/space_helper.dart';
import 'package:demo/utils/const/themes/colors.dart';
import 'package:demo/features/Saving%20Tips/model/savinr_tips_model.dart';

import 'package:demo/features/auth/controller/auth_controller.dart';
import 'package:demo/features/auth/screen/loginscreen.dart';
import 'package:demo/features/home/widgets/stepper_graph.dart';
// import 'package:demo/utils/const/widgets/internet_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/routes/routes.dart';
// import '../Saving Tips/controller/saving_tips_controller.dart';
import 'widgets/column_graphwidget.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});
  // List<SavingTips> data = [];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final savingTipsRepository = ref.watch(savingTipsRepositeryProvider);

    final authRepository = ref.watch(authControllerProvider);

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            vSpaceLarge,
            Row(
              children: [
                hSpaceMin,
                CircleAvatar(
                    radius: 5,
                    backgroundColor: Color.fromARGB(192, 246, 148, 2)),
                hSpaceMin,
                Text("H0y pris na")
              ],
            ),
            vSpaceMin,
            Text(
              '56 Ore',
              style: GoogleFonts.montserrat(
                  fontSize: 25, fontWeight: FontWeight.w500),
            ),
            vSpaceMedium,
            Text("Det er stor variasjon i dag"),
            vSpaceMedium,
            Card(child: const ColumnGraphWidget()),
            vSpaceRegular,
            Text(
              'Price Graph',
              style: GoogleFonts.montserrat(
                  fontSize: 25, fontWeight: FontWeight.w500),
            ),
            vSpaceRegular,
            const StepperGraphWidget(),
            vSpaceMedium,
          ]),
    ))));
  }
}
