import 'dart:developer';

import 'package:demo/utils/const/space_helper.dart';
import 'package:demo/utils/routes/routes.dart';
import 'package:flutter/material.dart';

class HvaKosterDetailedScreen extends StatelessWidget {
  HvaKosterDetailedScreen({super.key, required this.data, required this.index});
  List data;
  int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          children: [
            Column(children: [
              Row(children: [
                IconButton(
                    onPressed: () {
                      Routes.back();
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                const Text(
                  'Tilbake',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                hSpaceLarge,
                Text(
                  data[index]["details"]["front_end"],
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                )
              ]),
              vSpaceLarge,
              Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(children: [
                    Text(
                      data[index]['details']["description"].toString(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    Text(
                      "varghet: ${data[index]["details"]["duration_hours"].toString().substring(0, 3)} timer",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    )
                  ])),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${data[index]["cost"]['cheapest']["cost"]}Kr",
                      style: const TextStyle(
                          fontSize: 48, fontWeight: FontWeight.bold),
                    ),
                    vSpaceMedium,
                    Row(
                      children: [
                        const Icon(
                          Icons.arrow_circle_up_rounded,
                          color: Colors.red,
                        ),
                        hSpaceSmall,
                        Text(
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          "${data[index]['cost']['most_expensive']['cost']}kr ",
                        ),
                        Text(
                          "(kl. ${data[index]['cost']['most_expensive']['start_hour'].toString()}-${data[index]['cost']['most_expensive']['end_hour'].toString()})",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        hSpaceSmall,
                        const Icon(
                          Icons.arrow_circle_down_rounded,
                          color: Colors.green,
                        ),
                        hSpaceSmall,
                        Text(
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            "${data[index]['cost']['cheapest']['cost']}kr "),
                        Text(
                          "(kl. ${data[index]['cost']['cheapest']['start_hour'].toString()}-${data[index]['cost']['cheapest']['end_hour'].toString()})",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    vSpaceXl,
                    vSpaceXl,
                    vSpaceXl,
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: ClipPath(
                        child: Image.asset("assets/images/washing_machine.png"),
                      ),
                    )
                  ],
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }
}

class HvaDetailedWidget extends StatelessWidget {
  HvaDetailedWidget({Key? key, required this.data, required this.index})
      : super(key: key);
  final List data;
  final int index;

  Widget build(BuildContext context) {
    log(" index$index");
    log(data.length.toString());
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          controller: PageController(initialPage: index),
          // reverse: true, // Set reverse to true to swipe to the left
          itemCount: data.length,
          itemBuilder: (context, pageIndex) {
            // Create a function to build the content for each page

            return buildPageContent(pageIndex);
          },
        ),
      ),
    );
  }

  Widget buildPageContent(int pageIndex) {
    log("page index$pageIndex");
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                Routes.back();
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
            const Text(
              'Tilbake',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            hSpaceLarge,
            Text(
              data[pageIndex]["details"]["front_end"],
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        vSpaceLarge,
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Text(
                data[pageIndex]['details']["description"].toString(),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              Text(
                data[pageIndex]["details"]["duration_hours"]
                            .toString()
                            .split(".")
                            .last
                            .length >
                        2
                    ? "Varighet: ${data[pageIndex]["details"]["duration_hours"].toString().substring(0, 3)} timer"
                    : "Varighet: ${data[pageIndex]["details"]["duration_hours"].toString()} timer",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${data[pageIndex]["cost"]['cheapest']["cost"]}Kr",
                style:
                    const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              vSpaceMedium,
              Row(
                children: [
                  const Icon(
                    Icons.arrow_circle_up_rounded,
                    color: Colors.red,
                  ),
                  hSpaceSmall,
                  Text(
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    "${data[pageIndex]['cost']['most_expensive']['cost']}kr ",
                  ),
                  Text(
                    "(kl. ${data[pageIndex]['cost']['most_expensive']['start_hour'].toString()}-${data[pageIndex]['cost']['most_expensive']['end_hour'].toString()})",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  hSpaceSmall,
                  const Icon(
                    Icons.arrow_circle_down_rounded,
                    color: Colors.green,
                  ),
                  hSpaceSmall,
                  Text(
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      "${data[pageIndex]['cost']['cheapest']['cost']}kr "),
                  Text(
                    "(kl. ${data[pageIndex]['cost']['cheapest']['start_hour'].toString()}-${data[pageIndex]['cost']['cheapest']['end_hour'].toString()})",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              vSpaceXl,
              vSpaceXl,
              vSpaceXl,
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: data[pageIndex]["details"]["front_end"]
                            .toString()
                            .split(" ")
                            .first ==
                        "Dusj"
                    ? Image.asset(
                        width: 159,
                        height: 194,
                        fit: BoxFit.fill,
                        "assets/images/showerpng.png")
                    : data[pageIndex]["details"]["front_end"]
                                .toString()
                                .split("-")
                                .first ==
                            "Elbil"
                        ? Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            child: Image.asset(
                                width: 169,
                                height: 124,
                                fit: BoxFit.fill,
                                "assets/images/Component 1.png"),
                          )
                        : Image.asset(
                            width: 165,
                            height: 193,
                            fit: BoxFit.fill,
                            "assets/images/washingmachin.png"),
              ),
              Row(
                children: List.generate(data.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CircleAvatar(
                      backgroundColor: index == pageIndex
                          ? Colors.black
                          : const Color.fromARGB(255, 206, 206,
                              206), // Set your desired background color
                      radius: 6, // Adjust the size as needed
                    ),
                  );
                }),
              ),
            ],
          ),
        )
        // ... Rest of your content
      ],
    );
  }
}
