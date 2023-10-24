import 'dart:developer';

import 'package:demo/features/Hva%20Koster/view/detailed_hva_koster.dart';
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
                padding: const EdgeInsets.all(15),
                child: ListView.separated(
                    separatorBuilder: (context, index) => vSpaceRegular,
                    itemCount: datas.length,
                    itemBuilder: (context, index) {
                      return BygeNavCard(
                          title: datas[index]["details"]["front_end"],
                          destination: HvaKosterDetailedScreen(
                            data: datas,
                            index: index,
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            height: 110,
                            width: double.infinity,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      const Spacer(),
                                      const Text("Na"),
                                      Text(
                                          "${datas[index]["cost"]['current']['cost']}kr")
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    children: [
                                      const Spacer(),
                                      datas[index]["details"]["front_end"] ==
                                              "Dusj"
                                          ? Image.asset(
                                              width: 70,
                                              height: 60,
                                              fit: BoxFit.fill,
                                              "assets/images/showerpng.png")
                                          : datas[index]["details"]
                                                      ["front_end"] ==
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
