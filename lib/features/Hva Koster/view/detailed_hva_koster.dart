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
        child: Column(children: [
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
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
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
      ),
    );
  }
}
