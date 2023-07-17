import 'package:demo/const/themes/colors.dart';
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
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text(
          'HVA Koster',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ),
      body: Consumer<HvaController>(builder: (context, controller, _) {
        return SafeArea(
            child: controller.loader
                ? const Center(child: CircularProgressIndicator())
                : controller.firstLevelValues.isEmpty
                    ? const Center(child: Text("Data Not Available"))
                    : Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 15),
                        child: ListView.builder(
                            itemCount: controller.firstLevelValues.length,
                            itemBuilder: (context, index) {
                              Image image = controller.firstLevelValues[index]
                                          ['details']['front_end_text'] ==
                                      'Oppvaskmaskin'
                                  ? Image.asset(
                                      'assets/images/dish_washer.png',
                                      height: 50,
                                    )
                                  : controller.firstLevelValues[index]
                                              ['details']['front_end_text'] ==
                                          'Tørketrommel (60 grader)'
                                      ? Image.asset(
                                          'assets/images/dryer.png',
                                          height: 60,
                                        )
                                      : controller.firstLevelValues[index]
                                                      ['details']
                                                  ['front_end_text'] ==
                                              'Dusj (10 min)'
                                          ? Image.asset(
                                              'assets/images/shower.png',
                                              height: 50,
                                            )
                                          : controller.firstLevelValues[index]
                                                          ['details']
                                                      ['front_end_text'] ==
                                                  'Vaskemaskin'
                                              ? Image.asset(
                                                  'assets/images/washing_machine.png',
                                                  height: 50,
                                                )
                                              : Image.asset(
                                                  'assets/images/ev.png',
                                                  height: 50,
                                                );
                              return Container(
                                child: Column(children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          controller.firstLevelValues[index]
                                                      ['details']
                                                  ['front_end_text'] ??
                                              "",
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        image
                                      ]),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: size.width / 4,
                                        height: 35,
                                        color: const Color(0XFFdae1ef),
                                        child: const Center(
                                            child: Text(
                                          "Na",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        )),
                                      ),
                                      Container(
                                        color: const Color(0XFFdcefe9),
                                        width: size.width / 4,
                                        height: 35,
                                        child: const Center(
                                            child: Text("Biligst",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600))),
                                      ),
                                      Container(
                                        color: const Color(0XFFf6d7d3),
                                        width: size.width / 4,
                                        height: 35,
                                        child: const Center(
                                            child: Text("Dyrest",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600))),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: size.width / 4,
                                        height: 35,
                                        // color: const Color.fromARGB(255, 231, 193, 79),
                                        child: Center(
                                            child: Text(
                                          "${controller.firstLevelValues[index]['cost']['current']['cost'] ?? ""} kr",
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500),
                                        )),
                                      ),
                                      SizedBox(
                                        width: size.width / 4,
                                        height: 35,
                                        // color: const Color.fromARGB(255, 231, 193, 79),
                                        child: Center(
                                            child: Text(
                                                "${controller.firstLevelValues[index]['cost']['cheapest']['cost'] ?? ""} kr",
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w500))),
                                      ),
                                      SizedBox(
                                        width: size.width / 4,
                                        height: 35,
                                        // color: const Color.fromARGB(255, 231, 193, 79),
                                        child: Center(
                                            child: Text(
                                                "${controller.firstLevelValues[index]['cost']['most_expensive']['cost'] ?? ""} kr",
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w500))),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: size.width / 4,
                                        height: 35,
                                        // color: const Color.fromARGB(255, 231, 193, 79),
                                        child: const Center(
                                            child: Text("kl 16-17",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500))),
                                      ),
                                      SizedBox(
                                        width: size.width / 4,
                                        height: 35,
                                        // color: const Color.fromARGB(255, 231, 193, 79),
                                        child: const Center(
                                            child: Text("kl 22-23",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500))),
                                      ),
                                      SizedBox(
                                        width: size.width / 4,
                                        height: 35,
                                        // color: const Color.fromARGB(255, 231, 193, 79),
                                        child: const Center(
                                            child: Text("kl 17-18",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500))),
                                      ),
                                    ],
                                  )
                                ]),
                              );
                            }),
                      ));
      }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     HvaController().getHvaDetails();
      //   },
      // ),
    );
  }
}
