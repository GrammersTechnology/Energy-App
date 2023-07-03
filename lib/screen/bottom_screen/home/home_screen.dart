import 'package:demo/screen/bottom_screen/home/widget/columgraphwidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../auth/screen/loginscreen.dart';
import '../../../const/space_helper.dart';
import '../../../const/themes/colors.dart';
import '../../../controller/auth_controller.dart';
import '../../../controller/home_controller.dart';
import '../../../routes/routes.dart';
import '../repot/report_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    final controller = Provider.of<HomeController>(context, listen: false);

    Future.delayed(const Duration(seconds: 3)).then((value) {
      controller.fecthData(
        context,
      );
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context, listen: false);
    final Controller = Provider.of<HomeController>(context, listen: false);
    // final size = MediaQuery.of(context).size;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Controller.fecthData(context);
    });
    return Scaffold(
        drawer: GestureDetector(),
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: AppColors.primaryColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: GestureDetector(
            onTap: () {
              Controller.fecthData(
                context,
              );
            },
            child: Text(
              'Report Graph',
              style: GoogleFonts.montserrat(
                  fontSize: 25, fontWeight: FontWeight.w500),
            ),
          ),
          actions: [
            GestureDetector(
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.logout),
              ),
              onTap: () {
                authController.signout(context);
                authController.clearLocalData();
                Routes.pushreplace(screen: const LoginScreen());
              },
            )
          ],
        ),
        body: Consumer<HomeController>(
            builder: (context, homeController, widget) {
          return RefreshIndicator(
            onRefresh: () {
              return homeController.fecthData(context);
            },
            child: SingleChildScrollView(
                child: homeController.result.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 300),
                        child: Center(
                            child: GestureDetector(
                                onTap: () {
                                  Controller.fecthData(
                                    context,
                                  );
                                },
                                child: const CircularProgressIndicator())),
                      )
                    : Column(
                        children: [
                          Text(
                            'Price Predictor',
                            style: GoogleFonts.montserrat(
                                fontSize: 25, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const ColumnGraphWidget(),
                          const SizedBox(
                            height: 20,
                          ),
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
                                    Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: double.infinity,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15)),
                                                color: Color.fromARGB(
                                                    255, 236, 236, 236)),
                                            child: Center(
                                                child: Text(
                                              "EXR :${homeController.result[index]['EXR'].toString()} ",
                                              style: GoogleFonts.montserrat(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )),
                                          ),
                                          Container(
                                            height: 100,
                                            width: double.infinity,
                                            decoration: const BoxDecoration(
                                                color: AppColors.primaryColor),
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "NOK_Per_kWh :",
                                                            style: GoogleFonts
                                                                .nunitoSans(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            "\$ ${homeController.result[index]['NOK_per_kWh']}",
                                                            style: GoogleFonts
                                                                .archivo(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8),
                                                      child: Text(
                                                        "Time Starts : ${homeController.result[index]['time_start'].toString()}",
                                                        style: GoogleFonts.archivo(
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                199,
                                                                197,
                                                                197),
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 100,
                                            width: double.infinity,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(15),
                                                    bottomRight:
                                                        Radius.circular(15)),
                                                color: Color.fromARGB(
                                                    255, 243, 243, 243)),
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "EUR_Per_kWh :",
                                                            style: GoogleFonts
                                                                .nunitoSans(
                                                              color: AppColors
                                                                  .primaryColor,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            "\$ ${homeController.result[index]['EUR_per_kWh']}",
                                                            style: GoogleFonts.archivo(
                                                                color: AppColors
                                                                    .primaryColor,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8),
                                                      child: Text(
                                                        "Time Ends : ${homeController.result[index]['time_end'].toString()}",
                                                        style: GoogleFonts.archivo(
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                115,
                                                                113,
                                                                113),
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
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
