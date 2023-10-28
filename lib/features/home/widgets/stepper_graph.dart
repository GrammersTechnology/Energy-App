import 'dart:async';

import 'package:demo/features/home/controller/stepper_controller.dart';
import 'package:demo/features/home/model/home_model.dart';
import 'package:demo/utils/controller/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StepperGraphWidget extends ConsumerWidget {
  const StepperGraphWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Timer.periodic(const Duration(minutes: 30), (timer) {
      final stepperRepository = ref.watch(stepperGraphControllerProvider);
      stepperRepository.stepperGrahData();
    });
    return SizedBox(
      width: double.infinity,
      height: 250,
      child: ref.watch(stepperProvider).when(
            data: (data) {
              return SfCartesianChart(
                primaryXAxis: CategoryAxis(title: AxisTitle(text: "")),
                series: <ChartSeries>[
                  StepLineSeries<GraphData, String>(
                    dataSource: data,
                    xValueMapper: (GraphData sales, _) => sales.x.toString(),
                    yValueMapper: (GraphData sales, _) => sales.y,
                    // dataLabelSettings: DataLabelSettings(isVisible: true)
                  )
                ],
              );
            },
            error: (error, stackTrace) => const SafeArea(
                child: Center(child: Text("Something went wrong"))),
            loading: () {
              return const SafeArea(
                  child: Center(child: CircularProgressIndicator()));
            },
          ),
    );
  }
}
