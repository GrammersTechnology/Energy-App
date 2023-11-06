import 'dart:async';
import 'dart:developer';

import 'package:demo/features/home/controller/stepper_controller.dart';
import 'package:demo/features/home/model/home_model.dart';
import 'package:demo/utils/controller/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StepperGraphWidget extends ConsumerWidget {
  StepperGraphWidget({
    Key? key,
  }) : super(key: key);
  List<GraphData> data = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stepperRepository = ref.watch(stepperGraphControllerProvider);

    log("message");
    return SizedBox(
        width: double.infinity,
        height: 250,
        child: FutureBuilder(
          future: stepperRepository.stepperGrahData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              Text("error");
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return SfCartesianChart(
                primaryXAxis: CategoryAxis(title: AxisTitle(text: "")),
                series: <ChartSeries>[
                  StepLineSeries<GraphData, String>(
                    dataSource: snapshot.data ?? [],
                    xValueMapper: (GraphData sales, _) => sales.x.toString(),
                    yValueMapper: (GraphData sales, _) => sales.y,
                    // dataLabelSettings: DataLabelSettings(isVisible: true)
                  )
                ],
              );
              // List<GraphData> datadds = [];
              // datadds == snapshot.data;
              // log(snapshot.data.toString() + "FFFFFFFFFFFFFFf");
              // log(datadds.toString());
            }
            return SizedBox();
          },
        )

        // ref.read(stepperProvider).when(
        //       data: (data) {
        //         log("hhhhhhhhhhhhhhh");
        //         return SfCartesianChart(
        //           primaryXAxis: CategoryAxis(title: AxisTitle(text: "")),
        //           series: <ChartSeries>[
        //             StepLineSeries<GraphData, String>(
        //               dataSource: data,
        //               xValueMapper: (GraphData sales, _) => sales.x.toString(),
        //               yValueMapper: (GraphData sales, _) => sales.y,
        //               // dataLabelSettings: DataLabelSettings(isVisible: true)
        //             )
        //           ],
        //         );
        //       },
        //       error: (error, stackTrace) => const SafeArea(
        //           child: Center(child: Text("Something went wrong"))),
        //       loading: () {
        //         return const SafeArea(
        //             child: Center(child: CircularProgressIndicator()));
        //       },
        //     ),
        );
  }
}
