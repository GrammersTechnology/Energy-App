import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../controller/home_controller.dart';

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
              child: Text('Data Not Available'),
            );
    });
  }
}
