import 'package:demo/auth/screen/loginscreen.dart';
import 'package:demo/const/space_helper.dart';
import 'package:demo/controller/auth_controller.dart';
import 'package:demo/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../routes/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context, listen: false);
    final Controller = Provider.of<HomeController>(context, listen: false);
    final size = MediaQuery.of(context).size;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Controller.fecthData(
        context,
      );
    });
    return Scaffold(
        drawer: const SizedBox(),
        appBar: AppBar(
          actions: [
            GestureDetector(
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.logout),
              ),
              onTap: () {
                authController.signout();
                authController.clearLocalData();
                Routes.pushreplace(screen: const LoginScreen());
              },
            )
          ],
          centerTitle: true,
          title: const Text("Reports"),
        ),
        body: Consumer<HomeController>(
            builder: (context, homeController, widget) {
          return RefreshIndicator(
            onRefresh: () {
              return homeController.fecthData(context);
            },
            child: SingleChildScrollView(
                child: homeController.result.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.only(top: 300),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: homeController.result.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                          color: Colors.grey),
                                      // color: Colors.amber,
                                      // height: 60,
                                      width: size.width / 1.2,
                                      child: Column(
                                        children: [
                                          vSpaceMin,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  vSpaceMin,
                                                  Text(
                                                    "\$ ${homeController.result[index]['NOK_per_kWh']}",
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  vSpaceMin,
                                                  const Text("NOK_per_kWh"),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  vSpaceMin,
                                                  Text(
                                                    "\$ ${homeController.result[index]['EUR_per_kWh']}",
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  vSpaceMin,
                                                  const Text("EUR_per_kWh"),
                                                ],
                                              ),
                                            ],
                                          ),
                                          vSpaceMin,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  "time_start : ${homeController.result[index]['time_start'].toString()}"),
                                              Text(
                                                  "time_end : ${homeController.result[index]['time_end'].toString()}")
                                            ],
                                          ),
                                          vSpaceMin,
                                          Text(
                                              "EXR :${homeController.result[index]['EXR'].toString()} ")
                                        ],
                                      ),
                                    ),
                                    hSpaceMin,
                                    vSpaceMedium,
                                  ]),
                                );
                              },
                            ),
                          ),
                        ],
                      )),
          );
        }));
  }
}
