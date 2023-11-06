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

    // print("Inside of StepperGraphWidget");
    return SizedBox(
        width: double.infinity,
        height: 250,
        child: FutureBuilder(
          future: stepperRepository.stepperGrahData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              const Text("error");
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
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
            return const SizedBox();
          },
        ));
  }
}

class StepperGrapNextDayhWidget extends ConsumerWidget {
  StepperGrapNextDayhWidget({
    Key? key,
  }) : super(key: key);
  List<GraphData> data = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stepperRepository = ref.watch(stepperGraphControllerProvider);

    // print("Inside of StepperGraphWidget");
    return SizedBox(
        width: double.infinity,
        height: 250,
        child: FutureBuilder(
          future: stepperRepository.stepperGrahNextDayData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "The prices for tomorrow is\n        not available yet...",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
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
            } else {}
            return const SizedBox();
          },
        ));
  }
}
