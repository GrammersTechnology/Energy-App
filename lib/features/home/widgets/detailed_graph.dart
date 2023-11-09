import 'package:demo/features/home/widgets/column_graphwidget.dart';
import 'package:demo/features/home/widgets/stepper_graph.dart';
import 'package:demo/utils/const/space_helper.dart';
import 'package:demo/utils/const/widgets/byge-design-system/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/home_controller.dart';

class DetailedGraph extends ConsumerWidget {
  DetailedGraph(
      {super.key,
      // required this.child,
      required this.title,
      required this.iconDetails,
      required this.details,
      required this.onPress});
  // Widget child;
  String title;
  String details;
  String iconDetails;
  void Function() onPress;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeRepository = ref.watch(homeControllerProvider);
    ref.watch(showHomeControllerBoolStateProvider);
    return SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        IconButton(
            onPressed: onPress,
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 18,
            )),
        const Text(
          'Tilbake',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        hSpaceLarge,
        Text(
          homeRepository.toggelBool.first
              ? title
              : homeRepository.toggelBool.last
                  ? 'Strømprisvarrsel'
                  : title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        )
      ]),
      vSpaceLarge,
      Text(
        homeRepository.toggelBool.first
            ? details
            : homeRepository.toggelBool.last
                ? ''
                : details,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
      ),
      vSpaceLarge,
      Row(
        children: [
          Text(
            homeRepository.toggelBool.first
                ? iconDetails
                : homeRepository.toggelBool.last
                    ? 'Estimert snittspris per kWh neste 7 dager'
                    : iconDetails,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          hSpaceSmall,
          const Icon(
            Icons.help_outline_sharp,
            size: 30,
            color: Color.fromARGB(157, 37, 37, 37),
          )
        ],
      ),
      vSpaceLarge,
      homeRepository.toggelBool.first
          ? StepperGraphWidget()
          : homeRepository.toggelBool.last
              ? const ColumnGraphWidget()
              : StepperGrapNextDayhWidget(),
      vSpaceLarge,
      Container(
          width: 600,
          height: 80,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(20),
          child: ToggleButtons(
            borderColor: Colors.black,
            fillColor: Colors.black,
            borderRadius: BorderRadius.circular(15),
            selectedColor: Colors.white,
            selectedBorderColor: Colors.black,
            onPressed: (int index) async {
              final newStates = await homeRepository.changToggleButn(index);

              // showHomeControllerBoolStateProvider.read(context).state =
              //     newStates;

              ref.read(showHomeControllerBoolStateProvider.notifier).state =
                  newStates;

              print(index.toString());
            },
            isSelected: homeRepository.toggelBool,
            children: <Widget>[
              SizedBox(
                  width: (MediaQuery.of(context).size.width - 38) / 3.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "I dag",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: homeRepository.toggelBool.first == true
                                ? Colors.white
                                : Colors.black),
                      )
                    ],
                  )),
              SizedBox(
                  width: (MediaQuery.of(context).size.width - 36) / 3.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("I morgen",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: homeRepository.toggelBool.first ||
                                      homeRepository.toggelBool.last
                                  ? Colors.black
                                  : Colors.white))
                    ],
                  )),
              SizedBox(
                  width: (MediaQuery.of(context).size.width - 36) / 3.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Neste 7 dager",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: homeRepository.toggelBool.last == true
                                  ? Colors.white
                                  : Colors.black))
                    ],
                  )),
            ],
          )),
      Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              homeRepository.toggelBool.first == true
                  ? 'Hva er spotprisen?'
                  : homeRepository.toggelBool.last == true
                      ? 'Hvordan estimerer vi gjennomsnittspris?'
                      : 'Hva er spotprisen?',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            vSpaceSmall,
            Text(
              homeRepository.toggelBool.first == true
                  ? 'Strømprisen blir satt av Nord Pool, den nordiske\nkraftbørsen. Alle strømleverandører kjøper\nstrømmen til samme pris og selger den videre til\ndeg med et påslag.'
                  : homeRepository.toggelBool.last == true
                      ? 'Prisen som presenteres i prisvarselet er\nprognoser for gjennomsnittspris per kWh per\ndag de neste 7 dagene.\n \nStrømprisene våre bestemmes av tilbud og\netterspørsel, og prisen påvirkes av mange\nfaktorer, blant annet været her hjemme og i\nEuropa'
                      : 'Strømprisen blir satt av Nord Pool, den nordiske\nkraftbørsen. Alle strømleverandører kjøper\nstrømmen til samme pris og selger den videre til\ndeg med et påslag.',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
      vSpaceLarge,
    ]));
  }
}
