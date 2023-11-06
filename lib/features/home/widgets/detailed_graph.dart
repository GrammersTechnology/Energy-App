import 'package:demo/features/home/widgets/column_graphwidget.dart';
import 'package:demo/features/home/widgets/stepper_graph.dart';
import 'package:demo/utils/const/space_helper.dart';
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
    final columnBarState = ref.watch(showHomeControllerBoolStateProvider);

    return SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        IconButton(onPressed: onPress, icon: const Icon(Icons.arrow_back_ios)),
        const Text(
          'Tilbake',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        hSpaceMedium,
        Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        )
      ]),
      vSpaceLarge,
      Text(
        details,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
      ),
      vSpaceLarge,
      Row(
        children: [
          Text(
            iconDetails,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const Icon(
            Icons.question_mark_rounded,
            size: 15,
          )
        ],
      ),
      vSpaceLarge,
      homeRepository.toggelBool.first
          ? StepperGraphWidget()
          : homeRepository.toggelBool.last
              ? ColumnGraphWidget()
              : StepperGraphWidget(),
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
                  width: (MediaQuery.of(context).size.width - 38) / 4.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "HOT",
                        style: TextStyle(
                            color: homeRepository.toggelBool.first == true
                                ? Colors.white
                                : Colors.black),
                      )
                    ],
                  )),
              SizedBox(
                  width: (MediaQuery.of(context).size.width - 36) / 4.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("WARM",
                          style: TextStyle(
                              color: homeRepository.toggelBool.first ||
                                      homeRepository.toggelBool.last
                                  ? Colors.black
                                  : Colors.white))
                    ],
                  )),
              SizedBox(
                  width: (MediaQuery.of(context).size.width - 36) / 4.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("COLD",
                          style: TextStyle(
                              color: homeRepository.toggelBool.last == true
                                  ? Colors.white
                                  : Colors.black))
                    ],
                  )),
            ],
          )),
    ]));
  }
}
