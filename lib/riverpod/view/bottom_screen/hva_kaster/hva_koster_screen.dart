import 'dart:developer';

import 'package:demo/const/themes/colors.dart';
import 'package:demo/controller/hva_kaster_controller.dart';
import 'package:demo/riverpod/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

import '../../../../model/model.dart';

class HvaKosterScreen extends ConsumerWidget {
  const HvaKosterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          toolbarHeight: 80,
          centerTitle: true,
          title: const Text(
            'HVA Koster',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ),
        body: ref.watch(hvaProvider).when(
          data: (data) {
            log("message");
            log(data!.toJson().toString() + "ddddddddddddddddddddddddddd");
            return SafeArea(
                child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: ListView(children: [
                HvaWidget(
                    cheapestCost: data.dishWasher.cost.cheapest.cost.toString(),
                    cheapestStartHourEndHour:
                        data.dishWasher.cost.cheapest.startHour +
                            " - " +
                            data.dishWasher.cost.cheapest.endHour,
                    currentCost: data.dishWasher.cost.current.cost.toString(),
                    currentStartHourEndHour:
                        data.dishWasher.cost.current.startHour +
                            " - " +
                            data.dishWasher.cost.current.endHour,
                    mostExpensive:
                        data.dishWasher.cost.mostExpensive.cost.toString(),
                    mostExpensiveStartHourEndHour:
                        data.dishWasher.cost.mostExpensive.startHour +
                            " - " +
                            data.dishWasher.cost.mostExpensive.endHour,
                    size: size,
                    image: 'assets/images/dish_washer.png',
                    title: data.dishWasher.details.frontEndText),
                HvaWidget(
                    cheapestCost: data.dryer.cost.cheapest.cost.toString(),
                    cheapestStartHourEndHour:
                        data.dryer.cost.cheapest.startHour +
                            " - " +
                            data.dryer.cost.cheapest.endHour,
                    currentCost: data.dryer.cost.current.cost.toString(),
                    currentStartHourEndHour: data.dryer.cost.current.startHour +
                        " - " +
                        data.dryer.cost.current.endHour,
                    mostExpensive:
                        data.dryer.cost.mostExpensive.cost.toString(),
                    mostExpensiveStartHourEndHour:
                        data.dryer.cost.mostExpensive.startHour +
                            " - " +
                            data.dryer.cost.mostExpensive.endHour,
                    size: size,
                    image: 'assets/images/dryer.png',
                    title: data.dryer.details.frontEndText),
                HvaWidget(
                    cheapestCost: data.ev.cost.cheapest.cost.toString(),
                    cheapestStartHourEndHour: data.ev.cost.cheapest.startHour +
                        " - " +
                        data.ev.cost.cheapest.endHour,
                    currentCost: data.dishWasher.cost.current.cost.toString(),
                    currentStartHourEndHour: data.ev.cost.current.startHour +
                        " - " +
                        data.ev.cost.current.endHour,
                    mostExpensive: data.ev.cost.mostExpensive.cost.toString(),
                    mostExpensiveStartHourEndHour:
                        data.ev.cost.mostExpensive.startHour +
                            " - " +
                            data.ev.cost.mostExpensive.endHour,
                    size: size,
                    image: 'assets/images/ev.png',
                    title: data.ev.details.frontEndText),
                HvaWidget(
                    cheapestCost: data.shower.cost.cheapest.cost.toString(),
                    cheapestStartHourEndHour:
                        data.shower.cost.cheapest.startHour +
                            " - " +
                            data.shower.cost.cheapest.endHour,
                    currentCost: data.shower.cost.current.cost.toString(),
                    currentStartHourEndHour:
                        data.shower.cost.current.startHour +
                            " - " +
                            data.shower.cost.current.endHour,
                    mostExpensive:
                        data.shower.cost.mostExpensive.cost.toString(),
                    mostExpensiveStartHourEndHour:
                        data.shower.cost.mostExpensive.startHour +
                            " - " +
                            data.shower.cost.mostExpensive.endHour,
                    size: size,
                    image: 'assets/images/washing_machine.png',
                    title: data.shower.details.frontEndText),
                HvaWidget(
                    cheapestCost:
                        data.washingMachine.cost.cheapest.cost.toString(),
                    cheapestStartHourEndHour:
                        data.washingMachine.cost.cheapest.startHour +
                            " - " +
                            data.washingMachine.cost.cheapest.endHour,
                    currentCost:
                        data.washingMachine.cost.current.cost.toString(),
                    currentStartHourEndHour:
                        data.washingMachine.cost.current.startHour +
                            " - " +
                            data.washingMachine.cost.current.endHour,
                    mostExpensive:
                        data.washingMachine.cost.mostExpensive.cost.toString(),
                    mostExpensiveStartHourEndHour:
                        data.washingMachine.cost.mostExpensive.startHour +
                            " - " +
                            data.washingMachine.cost.mostExpensive.endHour,
                    size: size,
                    image: 'assets/images/shower.png',
                    title: data.washingMachine.details.frontEndText),
                // 'assets/images/dryer.png',
              ]),
            ));
          },
          error: (error, stackTrace) {
            return SafeArea(
                child: Center(
              child: Text("Something Went Wrong"),
            ));
          },
          loading: () {
            return SafeArea(
                child: Center(
              child: CircularProgressIndicator(),
            ));
          },
        ));
  }
}

class HvaWidget extends StatelessWidget {
  HvaWidget(
      {super.key,
      required this.size,
      required this.title,
      required this.image,
      required this.currentCost,
      required this.mostExpensive,
      required this.cheapestCost,
      required this.currentStartHourEndHour,
      required this.mostExpensiveStartHourEndHour,
      required this.cheapestStartHourEndHour});

  final Size size;
  String title,
      image,
      currentCost,
      mostExpensive,
      cheapestCost,
      currentStartHourEndHour,
      mostExpensiveStartHourEndHour,
      cheapestStartHourEndHour;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: 15,
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        // image
      ]),
      const SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: size.width / 4,
            height: 35,
            color: const Color(0XFFdae1ef),
            child: const Center(
                child: Text(
              "Na",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            )),
          ),
          Container(
            color: const Color(0XFFdcefe9),
            width: size.width / 4,
            height: 35,
            child: const Center(
                child: Text("Biligst",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w600))),
          ),
          Container(
            color: const Color(0XFFf6d7d3),
            width: size.width / 4,
            height: 35,
            child: const Center(
                child: Text("Dyrest",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w600))),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: size.width / 4,
            height: 35,
            // color: const Color.fromARGB(255, 231, 193, 79),
            child: Center(
                child: Text(
              "${currentCost} ${"kr"}",
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            )),
          ),
          SizedBox(
            width: size.width / 4,
            height: 35,
            // color: const Color.fromARGB(255, 231, 193, 79),
            child: Center(
                child: Text("${cheapestCost} ${"kr"}",
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w500))),
          ),
          SizedBox(
            width: size.width / 4,
            height: 35,
            // color: const Color.fromARGB(255, 231, 193, 79),
            child: Center(
                child: Text("${mostExpensive} ${"kr"}",
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w500))),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: size.width / 4,
            height: 35,
            // color: const Color.fromARGB(255, 231, 193, 79),
            child: Center(
                child: Text("kl ${currentStartHourEndHour}",
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500))),
          ),
          SizedBox(
            width: size.width / 4,
            height: 35,
            // color: const Color.fromARGB(255, 231, 193, 79),
            child: Center(
                child: Text("kl ${cheapestStartHourEndHour}",
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500))),
          ),
          SizedBox(
            width: size.width / 4,
            height: 35,
            // color: const Color.fromARGB(255, 231, 193, 79),
            child: Center(
                child: Text("kl ${mostExpensiveStartHourEndHour}",
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500))),
          ),
        ],
      )
    ]);
  }
}
