import 'package:demo/features/home/controller/home_controller.dart';
import 'package:demo/features/home/model/home_model.dart';
import 'package:demo/utils/const/space_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/stepper_controller.dart';

class HomeScrnWidget extends ConsumerWidget {
  HomeScrnWidget({super.key, required this.boolean});
  bool boolean;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: StepperController().homeStringGet(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          HomeScrnString? response = snapshot.data;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              vSpaceRegular,
              Row(
                children: [
                  hSpaceMin,
                  CircleAvatar(
                      radius: 5,
                      backgroundColor: response!.priceLevel == 0
                          ? Colors.green
                          : response.priceLevel == 1
                              ? Colors.green
                              : response.priceLevel == 2
                                  ? Colors.yellow
                                  : response.priceLevel == 3
                                      ? Colors.red
                                      : response.priceLevel == 4
                                          ? Colors.red
                                          : Colors.white),
                  hSpaceMin,
                  response.priceLevel == 0
                      ? const Text(
                          "Veldig lav pris nå",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        )
                      : response.priceLevel == 1
                          ? const Text(
                              "Lav pris nå",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            )
                          : response.priceLevel == 2
                              ? const Text(
                                  "Normal pris nå",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                )
                              : response.priceLevel == 3
                                  ? const Text(
                                      "H0y pris na",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    )
                                  : response.priceLevel == 4
                                      ? const Text(
                                          "Veldig høy pris nå",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        )
                                      : const Text("")
                ],
              ),
              boolean
                  ? Column(
                      children: [
                        vSpaceMin,
                        Text(
                          '${response.price.round()} øre',
                          style: GoogleFonts.montserrat(
                              fontSize: 48, fontWeight: FontWeight.bold),
                        ),
                        vSpaceRegular,
                      ],
                    )
                  : const SizedBox(
                      height: 15,
                    ),
              Row(
                children: [
                  const Text(
                    "Det er ",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                  ),
                  response.priceVariation == 0
                      ? const Text(
                          "Liten variasjon",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w700),
                        )
                      : response.priceVariation == 1
                          ? const Text(
                              "Stor variasjon ",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w700),
                            )
                          : const Text(""),
                  const Text(
                    "i dag",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              vSpaceMedium,
            ],
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Data Not Available Now"),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          const CircularProgressIndicator();
        }
        return Container();
      },
    );
  }
}
