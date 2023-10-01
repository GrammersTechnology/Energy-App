import 'package:demo/riverpod/home/model/home_model.dart';
import 'package:demo/riverpod/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ColumnGraphWidget extends ConsumerWidget {
  const ColumnGraphWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
        height: 250,
        child: ref.watch(columnProvider).when(
              data: (columnData) {
                return columnData.isNotEmpty
                    ? SfCartesianChart(
                        primaryXAxis: CategoryAxis(title: AxisTitle(text: "")),
                        series: <ChartSeries>[
                            ColumnSeries<GraphData, String>(
                                dataSource: columnData,
                                xValueMapper: (GraphData data, _) =>
                                    data.x.toString(),
                                yValueMapper: (GraphData data, _) => data.y,
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true))
                          ])
                    : Text("Data is Empty");
              },
              error: (error, stackTrace) =>
                  SafeArea(child: Text("Something went Rong")),
              loading: () {
                return SafeArea(
                    child: Center(child: CircularProgressIndicator()));
              },
            ));
  }
}
