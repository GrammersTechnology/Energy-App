import 'package:demo/features/home/model/home_model.dart';
import 'package:demo/utils/controller/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:developer';

class ColumnGraphWidget extends ConsumerWidget {
  const ColumnGraphWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // print('building inside ColumnGraphWidget');
    return SizedBox(
        height: 250,
        child: ref.watch(columnProvider).when(
              data: (columnData) {
                return columnData.isNotEmpty
                    ? SfCartesianChart(
                        primaryYAxis: NumericAxis(
                            isVisible: false,
                            //Hide the gridlines of y-axis
                            majorGridLines: const MajorGridLines(width: 0),
                            //Hide the axis line of y-axis
                            axisLine: const AxisLine(width: 0)),
                        plotAreaBorderWidth: 0,
                        borderColor: Colors.transparent,
                        backgroundColor: Colors.white,
                        enableSideBySideSeriesPlacement: false,
                        primaryXAxis: CategoryAxis(
                            title: AxisTitle(
                              text: "",
                            ),
                            majorGridLines: const MajorGridLines(width: 0),
                            axisLine: const AxisLine(width: 0)),
                        series: <ChartSeries>[
                            ColumnSeries<GraphData, String>(
                              // spacing: 150,
                              borderRadius: BorderRadius.circular(6),
                              dataLabelSettings:
                                  const DataLabelSettings(isVisible: true),
                              color: Colors.amber,
                              dataSource: columnData,
                              xValueMapper: (GraphData data, _) => data.x,
                              yValueMapper: (GraphData data, _) => data.y,
                              pointColorMapper: (datum, index) => datum.color,
                            )
                          ])
                    : const Text("Data is Empty");
              },
              error: (error, stackTrace) =>
                  const SafeArea(child: Text("Something went wrong")),
              loading: () {
                return const SafeArea(
                    child: Center(child: CircularProgressIndicator()));
              },
            ));
  }
}
