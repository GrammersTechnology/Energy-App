import 'package:demo/const/space_helper.dart';
import 'package:demo/controller/hva_kaster_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HvaKosterScreen extends StatelessWidget {
  const HvaKosterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final hvaController = Provider.of<HvaController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      hvaController.getHvaDetails();
    });
    return Scaffold(
      body: Consumer<HvaController>(builder: (context, controller, _) {
        return SafeArea(
            child: controller.loader
                ? CircularProgressIndicator()
                : controller.firstLevelValues.isEmpty
                    ? Center(child: Text("Data Not Available"))
                    : ListView.builder(
                        itemCount: controller.firstLevelValues.length,
                        itemBuilder: (context, index) {
                          IconData icon = controller.firstLevelValues[index]
                                      ['details']['front_end_text'] ==
                                  ''
                              ? Icons.wine_bar_rounded
                              : controller.firstLevelValues[index]['details']
                                          ['front_end_text'] ==
                                      ''
                                  ? Icons.fire_hydrant_alt_rounded
                                  : controller.firstLevelValues[index]
                                              ['details']['front_end_text'] ==
                                          ''
                                      ? Icons.directions_car_sharp
                                      : controller.firstLevelValues[index]
                                                      ['details']
                                                  ['front_end_text'] ==
                                              ''
                                          ? Icons.bathtub_rounded
                                          : Icons.ac_unit;
                          return Container(
                            child: Column(children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(controller.firstLevelValues[index]
                                            ['details']['front_end_text'] ??
                                        ""),
                                    Icon(icon)
                                  ]),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: size.width / 4,
                                    height: 35,
                                    color:
                                        const Color.fromARGB(255, 231, 193, 79),
                                    child: const Center(child: Text("Na")),
                                  ),
                                  Container(
                                    color: const Color.fromARGB(
                                        255, 124, 231, 250),
                                    width: size.width / 4,
                                    height: 35,
                                    child: const Center(child: Text("Biligst")),
                                  ),
                                  Container(
                                    color:
                                        const Color.fromARGB(255, 240, 92, 141),
                                    width: size.width / 4,
                                    height: 35,
                                    child: const Center(child: Text("Dyrest")),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: size.width / 4,
                                    height: 35,
                                    // color: const Color.fromARGB(255, 231, 193, 79),
                                    child: Center(
                                        child: Text(
                                            "${controller.firstLevelValues[index]['cost']['current']['cost'] ?? ""} kr")),
                                  ),
                                  Container(
                                    width: size.width / 4,
                                    height: 35,
                                    // color: const Color.fromARGB(255, 231, 193, 79),
                                    child: Center(
                                        child: Text(
                                            "${controller.firstLevelValues[index]['cost']['cheapest']['cost'] ?? ""} kr")),
                                  ),
                                  Container(
                                    width: size.width / 4,
                                    height: 35,
                                    // color: const Color.fromARGB(255, 231, 193, 79),
                                    child: Center(
                                        child: Text(
                                            "${controller.firstLevelValues[index]['cost']['most_expensive']['cost'] ?? ""} kr")),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: size.width / 4,
                                    height: 35,
                                    // color: const Color.fromARGB(255, 231, 193, 79),
                                    child:
                                        const Center(child: Text("kl 16-17")),
                                  ),
                                  Container(
                                    width: size.width / 4,
                                    height: 35,
                                    // color: const Color.fromARGB(255, 231, 193, 79),
                                    child:
                                        const Center(child: Text("kl 22-23")),
                                  ),
                                  Container(
                                    width: size.width / 4,
                                    height: 35,
                                    // color: const Color.fromARGB(255, 231, 193, 79),
                                    child:
                                        const Center(child: Text("kl 17-18")),
                                  ),
                                ],
                              )
                            ]),
                          );
                        }));
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HvaController().getHvaDetails();
        },
      ),
    );
  }
}
