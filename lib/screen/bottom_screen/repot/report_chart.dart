import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/const/themes/colors.dart';
import 'package:demo/controller/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../controller/home_controller.dart';

class ReoprtScreen extends StatefulWidget {
  const ReoprtScreen({super.key});

  @override
  State<ReoprtScreen> createState() => _ReoprtScreenState();
}

class _ReoprtScreenState extends State<ReoprtScreen> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth fb = FirebaseAuth.instance;

  String zoneId = '';

  void getData() {
    db
        .collection('user')
        .doc(fb.currentUser?.uid)
        // .collection("auth")
        .get()
        .then((value) {
      final data = UserModel.fromJson(value.data()!);
      setState(() {
        zoneId = data.zone.toString();
      });
    }).catchError((error) {
      print('Error retrieving data: $error');
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context, listen: false);
    // final authController = Provider.of<AuthController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: GestureDetector(
          onTap: () {
            controller.fecthData(
              context,
            );
          },
          child: Text(
            'Report Graph',
            style: GoogleFonts.montserrat(
                fontSize: 25, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Text(
                'Price Graph',
                style: GoogleFonts.montserrat(
                    fontSize: 25, fontWeight: FontWeight.w500),
              ),
              const StepperGraphWidget(),
              const SizedBox(
                height: 20,
              ),
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
              Text(
                'Zone Details',
                style: GoogleFonts.montserrat(
                    fontSize: 25, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(15),
                            //  borderRadius: BorderRadius.only(
                            //     topLeft: Radius.circular(15),
                            //     topRight: Radius.circular(15)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Zone :  $zoneId",
                                style: GoogleFonts.nunitoSans(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          )),
                      // Container(
                      //     height: 100,
                      //     width: double.infinity,
                      //     decoration: const BoxDecoration(
                      //         borderRadius: BorderRadius.only(
                      //             bottomLeft: Radius.circular(15),
                      //             bottomRight: Radius.circular(15)),
                      //         color: Color.fromARGB(255, 243, 243, 243)),
                      //     child: Column(
                      //       children: [
                      //         Text(
                      //           "NOK_Per_kWh :",
                      //           style: GoogleFonts.nunitoSans(
                      //             color: Colors.white,
                      //             fontSize: 18,
                      //             fontWeight: FontWeight.w900,
                      //           ),
                      //         ),
                      //       ],
                      //     )),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColumnGraphWidget extends StatelessWidget {
  const ColumnGraphWidget({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final controller = Provider.of<HomeController>(context, listen: false);
      controller.feacthColumnGraphData(context);
    });
    return Consumer<HomeController>(builder: (context, controller, widget) {
      return controller.columnGraphData.isNotEmpty
          ? SizedBox(
              height: 250,
              child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(title: AxisTitle(text: "")),
                  series: <ChartSeries>[
                    ColumnSeries<GraphData, String>(
                        dataSource: controller.columnGraphData,
                        xValueMapper: (GraphData data, _) => data.x.toString(),
                        yValueMapper: (GraphData data, _) => data.y,
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: true))
                  ]))
          : const Center(
              child: CircularProgressIndicator(),
            );
    });
  }
}

class StepperGraphWidget extends StatelessWidget {
  const StepperGraphWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(builder: (context, controller, widget) {
      print("sssssssssss${controller.stepLineGraph.first.y.runtimeType}");
      return StreamBuilder<List<GraphData>>(
        stream: controller.graphDataStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<GraphData> graphDataList = snapshot.data!;
            return SizedBox(
              width: double.infinity,
              height: 250,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(title: AxisTitle(text: "")),
                series: <ChartSeries>[
                  StepLineSeries<GraphData, String>(
                    dataSource: graphDataList,
                    xValueMapper: (GraphData sales, _) => sales.x.toString(),
                    yValueMapper: (GraphData sales, _) => sales.y,
                    // dataLabelSettings: DataLabelSettings(isVisible: true)
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    });
  }
}
