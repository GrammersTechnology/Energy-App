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
                    cheapestCost: "dfssss",
                    cheapestStartHourEndHour: "d",
                    currentCost: "sdf",
                    currentStartHourEndHour: "fd",
                    mostExpensive: "rf",
                    mostExpensiveStartHourEndHour: "df",
                    size: size,
                    image: 'assets/images/dish_washer.png',
                    title: data!.dishWasher.details.frontEndText),
                HvaWidget(
                    cheapestStartHourEndHour: "",
                    currentCost: "",
                    currentStartHourEndHour: "",
                    mostExpensive: "",
                    mostExpensiveStartHourEndHour: "",
                    cheapestCost: "",
                    size: size,
                    image: 'assets/images/dryer.png',
                    title: data.dryer.details.frontEndText),
                HvaWidget(
                    cheapestStartHourEndHour: "",
                    currentCost: "",
                    currentStartHourEndHour: "",
                    mostExpensive: "",
                    mostExpensiveStartHourEndHour: "",
                    cheapestCost: "",
                    size: size,
                    image: 'assets/images/ev.png',
                    title: data.dishWasher.details.frontEndText),
                HvaWidget(
                    cheapestStartHourEndHour: "",
                    cheapestCost: "",
                    currentCost: "",
                    currentStartHourEndHour: "",
                    mostExpensive: "",
                    mostExpensiveStartHourEndHour: "",
                    size: size,
                    image: 'assets/images/washing_machine.png',
                    title: data.dishWasher.details.frontEndText),
                HvaWidget(
                    cheapestCost: "",
                    cheapestStartHourEndHour: "",
                    currentCost: "",
                    currentStartHourEndHour: "",
                    mostExpensive: "",
                    mostExpensiveStartHourEndHour: "",
                    size: size,
                    image: 'assets/images/shower.png',
                    title: data.dishWasher.details.frontEndText),
                // 'assets/images/dryer.png',
              ]),
            ));
          },
          error: (error, stackTrace) {
            return SafeArea(
                child: Center(
              child: Text("data"),
            ));
          },
          loading: () {
            return SafeArea(child: Center());
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
