import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../controller/home_controller.dart';

class ColumnGraphWidget extends StatelessWidget {
  const ColumnGraphWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: Text('Data Not Available'),
            );
    });
  }
}

class StepperGraphWidget extends StatelessWidget {
  const StepperGraphWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(builder: (context, controller, widget) {
      return controller.loader
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : controller.stepLineGraph.isEmpty
              ? const Center(
                  child: Text("Graph Not Avaibale"),
                )
              : SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(title: AxisTitle(text: "")),
                    series: <ChartSeries>[
                      StepLineSeries<GraphData, String>(
                        dataSource: controller.stepLineGraph,
                        xValueMapper: (GraphData sales, _) =>
                            sales.x.toString(),
                        yValueMapper: (GraphData sales, _) => sales.y,
                        // dataLabelSettings: DataLabelSettings(isVisible: true)
                      )
                    ],
                  ),
                );
    });
  }
}
