import 'package:demo/features/home/model/home_model.dart';
import 'package:demo/utils/const/space_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/stepper_controller.dart';

class HomeScrnWidget extends ConsumerWidget {
  const HomeScrnWidget({super.key});

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
              vSpaceLarge,
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
                      ? const Text("Veldig lav pris nå")
                      : response.priceLevel == 1
                          ? const Text("Lav pris nå")
                          : response.priceLevel == 2
                              ? const Text("Normal pris nå")
                              : response.priceLevel == 3
                                  ? const Text("H0y pris na")
                                  : response.priceLevel == 4
                                      ? const Text("Veldig høy pris nå")
                                      : const Text("")
                ],
              ),
              vSpaceMin,
              Text(
                '${response.price.round()} øre',
                style: GoogleFonts.montserrat(
                    fontSize: 25, fontWeight: FontWeight.w500),
              ),
              vSpaceMedium,
              Row(
                children: [
                  const Text("Det er "),
                  response.priceVariation == 0
                      ? const Text("Liten variasjon")
                      : response.priceVariation == 1
                          ? const Text("Stor variasjon ")
                          : const Text(""),
                  const Text("i dag"),
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
