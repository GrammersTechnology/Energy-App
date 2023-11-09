import 'dart:developer';

import 'package:demo/features/Hva%20Koster/view/detailed_hva_koster.dart';
import 'package:demo/features/home/widgets/home_screen_widget.dart';
import 'package:demo/utils/const/space_helper.dart';
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
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              HomeScrnWidget(boolean: false),
              Expanded(
                child: ListView.separated(
                    separatorBuilder: (context, index) => vSpaceRegular,
                    itemCount: datas.length,
                    itemBuilder: (context, index) {
                      return BygeNavCard(
                          title: datas[index]["details"]["front_end"],
                          destination: HvaDetailedWidget(
                            data: datas,
                            index: index,
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            height: 70,
                            width: double.infinity,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Spacer(),
                                      const Text(
                                        "Na",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      vSpaceMin,
                                      Text(
                                        "${datas[index]["cost"]['current']['cost']}kr",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    children: [
                                      const Spacer(),
                                      datas[index]["details"]["front_end"]
                                                  .toString()
                                                  .split(" ")
                                                  .first ==
                                              "Dusj"
                                          ? Image.asset(
                                              width: 40,
                                              height: 45,
                                              fit: BoxFit.fill,
                                              "assets/images/showerpng.png")
                                          : datas[index]["details"]["front_end"]
                                                      .toString()
                                                      .split("-")
                                                      .first ==
                                                  "Elbil"
                                              ? Image.asset(
                                                  width: 55,
                                                  height: 35,
                                                  fit: BoxFit.fill,
                                                  "assets/images/Component 1.png")
                                              : Image.asset(
                                                  width: 40,
                                                  height: 45,
                                                  fit: BoxFit.fill,
                                                  "assets/images/washingmachin.png"),
                                    ],
                                  )
                                ]),
                          ));
                    }),
              ),
            ],
          ),
        ));
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
