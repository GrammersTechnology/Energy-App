import 'package:demo/const/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../const/space_helper.dart';
import '../../../controller/chartcontroller.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Controller = Provider.of<ChartController>(context, listen: false);
    // final homeController = Provider.of<HomeController>(context, listen: false);
    final size = MediaQuery.of(context).size;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Controller.getChartDetails(context, '');
    });
    return Consumer<ChartController>(builder: (context, controller, widget) {
      return Scaffold(
        body: SafeArea(
          child: controller.loader == true
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: controller.data == null
                      ? Padding(
                          padding: const EdgeInsets.only(top: 150),
                          child: Center(
                            child: Column(
                              children: const [
                                CircularProgressIndicator(),
                                Text("Finding Data.."),
                              ],
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: size.width / 2,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      // border: Border.all(color: Colors.grey)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: DropdownButton(
                                        iconEnabledColor: AppColors.whiteColor,
                                        focusColor: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        hint: Text(
                                          controller.dropdowmValue ?? " NO1",
                                          style: const TextStyle(
                                              color: AppColors.whiteColor),
                                        ),
                                        underline: const SizedBox(),
                                        isExpanded: true,
                                        items: controller.dropdwonList
                                            .map((e) => DropdownMenuItem(
                                                value: e, child: Text(e)))
                                            .toList(),
                                        onChanged: (value) {
                                          controller.changeDropDownValue(value);
                                        },
                                        onTap: () {},
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Ar: ${controller.data!.isoAar.toString()}",
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "Uke:${controller.data!.isoUke.toString()}",
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    "  ${controller.data!.fyllingsgrad}",
                                                    style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w600),
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
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                  Text(
                                                      "  ${controller.data!.kapasitetTWh}",
                                                      style: const TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w600)),
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
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                  Text(
                                                      " ${controller.data!.fyllingTWh}",
                                                      style: const TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w600)),
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
                                        color:
                                            Color.fromARGB(255, 224, 222, 222),
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
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                      "${controller.data!.fyllingTWh.toString().substring(0, 5)} TWh",
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500)),
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
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                      "${controller.data!.fyllingsgradForrigeUke.toString().substring(0, 5)} %",
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                      "Ending fyllingsgrad",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                      "${controller.data!.endringFyllingsgrad.toString().substring(0, 5)} %",
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
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
        ),
      );
    });
  }
}
