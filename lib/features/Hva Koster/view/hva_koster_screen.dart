import 'dart:developer';

import 'package:demo/utils/const/space_helper.dart';
import 'package:demo/utils/const/themes/colors.dart';
import 'package:demo/utils/controller/provider.dart';
import 'package:demo/utils/const/widgets/internet_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/const/widgets/byge-design-system/cards/byge_nav_card.dart';

class HvaKosterScreen extends ConsumerWidget {
  const HvaKosterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: ref.watch(hvaProvider).when(
      data: (datas) {
        // userRepositeryProvider
        log("message");

        return SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(15),
                child: ListView.separated(
                    separatorBuilder: (context, index) => vSpaceRegular,
                    itemCount: datas.length,
                    itemBuilder: (context, index) {
                      return BygeNavCard(
                          title: datas[index]["details"]["front_end_text"],
                          destination: Container(),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Spacer(),
                                      Text("Na"),
                                      Text(
                                          "${datas[index]["cost"]['current']['cost']}kr")
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    children: [
                                      Spacer(),
                                      datas[index]["details"]
                                                  ["front_end_text"] ==
                                              "Dusj"
                                          ? Image.asset(
                                              width: 70,
                                              height: 60,
                                              fit: BoxFit.fill,
                                              "assets/images/showerpng.png")
                                          : datas[index]["details"]
                                                      ["front_end_text"] ==
                                                  "Elbil"
                                              ? Image.asset(
                                                  width: 70,
                                                  height: 60,
                                                  fit: BoxFit.fill,
                                                  "assets/images/Component 1.png")
                                              : Image.asset(
                                                  width: 70,
                                                  height: 60,
                                                  fit: BoxFit.fill,
                                                  "assets/images/washing_machine.png"),
                                    ],
                                  )
                                ]),
                            height: 110,
                            width: double.infinity,
                          ));
                    })));
      },
      error: (error, stackTrace) {
        return const SafeArea(child: InternetChecking());
      },
      loading: () {
        return const SafeArea(
            child: Center(
          child: CircularProgressIndicator(),
        ));
      },
    ));
  }
}

class HvaWidget extends StatelessWidget {
  const HvaWidget(
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
  final String title,
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
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
              "$currentCost ${"kr"}",
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            )),
          ),
          SizedBox(
            width: size.width / 4,
            height: 35,
            // color: const Color.fromARGB(255, 231, 193, 79),
            child: Center(
                child: Text("$cheapestCost ${"kr"}",
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w500))),
          ),
          SizedBox(
            width: size.width / 4,
            height: 35,
            // color: const Color.fromARGB(255, 231, 193, 79),
            child: Center(
                child: Text("$mostExpensive ${"kr"}",
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
                child: Text("kl $currentStartHourEndHour",
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500))),
          ),
          SizedBox(
            width: size.width / 4,
            height: 35,
            // color: const Color.fromARGB(255, 231, 193, 79),
            child: Center(
                child: Text("kl $cheapestStartHourEndHour",
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500))),
          ),
          SizedBox(
            width: size.width / 4,
            height: 35,
            // color: const Color.fromARGB(255, 231, 193, 79),
            child: Center(
                child: Text("kl $mostExpensiveStartHourEndHour",
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500))),
          ),
        ],
      )
    ]);
  }
}
