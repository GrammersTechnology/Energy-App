import 'package:demo/const/themes/colors.dart';
import 'package:demo/riverpod/chart/controller/chartcontroller.dart';
import 'package:demo/riverpod/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../const/space_helper.dart';

class ChartScreen extends ConsumerWidget {
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chartRepository = ref.watch(userChartProvider);

    ref.watch(chartDropdownListProvider);

    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: ref.watch(chartProvider).when(
      data: (data) {
        ref.watch(chartProvider.future);
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: size.width / 2,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          // border: Border.all(color: Colors.grey)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: DropdownButton(
                            iconEnabledColor: AppColors.whiteColor,
                            focusColor: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            // value: ref.watch(dropdownListProvider),
                            hint: Text(
                              chartRepository.dropdowmValue ?? " NO1",
                              style:
                                  const TextStyle(color: AppColors.whiteColor),
                            ),
                            // value: selectedValue,
                            underline: const SizedBox(),
                            isExpanded: true,
                            items: chartRepository.dropdwonList
                                .map((e) =>
                                    DropdownMenuItem(value: e, child: Text(e)))
                                .toList(),
                            onChanged: (value) {
                              chartRepository.changeDropDownValue(value);

                              ref
                                  .read(chartDropdownListProvider.notifier)
                                  .state = value.toString();
                              // userChartProvider.read(
                              //     chartRepository.changeDropDownValue(value));
                            },
                          ),
                        ),
                      ),
                      Text(
                        "Ar: ${chartRepository.data?.isoAar}",
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Uke:${chartRepository.data?.isoUke}",
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                vSpaceRegular,
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      // height: 500,
                      child: Image.asset(
                        "assets/images/location.jpeg",
                        fit: BoxFit.fill,
                        // height: 100,
                      ),
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.water_drop,
                                    size: 30,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Vann i magasinet  ",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "  ${chartRepository.data?.fyllingsgrad.toString().substring(0, 4)}",
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              vSpaceSmall,
                              Row(
                                children: [
                                  const Icon(
                                    Icons.battery_charging_full,
                                    size: 30,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Kapasitet",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600)),
                                      Text(
                                          "  ${chartRepository.data?.kapasitetTWh.toString().substring(0, 4)}",
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ],
                              ),
                              vSpaceSmall,
                              Row(
                                children: [
                                  const Icon(
                                    Icons.more_horiz,
                                    size: 30,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Normalt niva ",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600)),
                                      Text(
                                          " ${chartRepository.data?.fyllingTWh.toString().substring(0, 4)}",
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ],
                              ),
                            ]),
                      ],
                    ),
                    vSpaceLarge,
                    Row(
                      children: [
                        // hSpaceRegular,
                        Container(
                          width: size.width,
                          height: 70,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 224, 222, 222),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 18, right: 18, top: 18),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text("Fylling",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "${chartRepository.data?.fyllingTWh.round()} TWh",
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 0,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text("Forrige uke",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "${chartRepository.data?.fyllingsgradForrigeUke.toString().substring(0, 4)} %",
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text("Ending fyllingsgrad",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "${chartRepository.data?.endringFyllingsgrad.toString().substring(0, 4)} %",
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ],
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return const SafeArea(
            child: Center(
          child: Text("Something Went Wrong"),
        ));
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
