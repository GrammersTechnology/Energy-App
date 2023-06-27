import 'package:demo/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../const/space_helper.dart';
import '../../../controller/chartcontroller.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Controller = Provider.of<ChartController>(context, listen: false);
    final size = MediaQuery.of(context).size;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Controller.getChartDetails(context, '');
    });
    return Consumer<ChartController>(builder: (context, controller, widget) {
      return Scaffold(
        body: SafeArea(
          child: controller.loader == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: controller.data == null
                      ? Center(
                          child: Text("Data Not Avaibale"),
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
                                      color: Colors.grey,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      // border: Border.all(color: Colors.grey)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: DropdownButton(
                                        hint: Text(
                                            controller.dropdowmValue ?? " NO1"),
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
                                      "Ar:${controller.data!.isoAar.toString()}"),
                                  Text(
                                      "Uke:${controller.data!.isoUke.toString()}"),
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
                                    Spacer(),
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.water_drop),
                                              Column(
                                                children: [
                                                  Text("Vann i magasinet"),
                                                  Text(
                                                      "${controller.data!.fyllingsgrad.toString()}"),
                                                ],
                                              ),
                                            ],
                                          ),
                                          vSpaceSmall,
                                          Row(
                                            children: [
                                              Icon(Icons.battery_charging_full),
                                              Column(
                                                children: [
                                                  Text("Kapasitet"),
                                                  Text(
                                                      "${controller.data!.kapasitetTWh.toString()}"),
                                                ],
                                              ),
                                            ],
                                          ),
                                          vSpaceSmall,
                                          Row(
                                            children: [
                                              Icon(Icons.more_horiz),
                                              Column(
                                                children: [
                                                  Text("Normalt niva "),
                                                  Text(
                                                      "${controller.data!.fyllingTWh.toString()}"),
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
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        color: Colors.grey,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Text("Fylling"),
                                                  Text(
                                                      "${controller.data!.fyllingTWh.toString()}"),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text("Forrige uke"),
                                                  Text(
                                                      "${controller.data!.fyllingsgradForrigeUke.toString()}"),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text("Ending fyllingsgrad"),
                                                  Text(
                                                      "${controller.data!.endringFyllingsgrad.toString()}"),
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
