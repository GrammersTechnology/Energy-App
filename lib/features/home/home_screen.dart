// ignore_for_file: must_be_immutable

import 'package:demo/features/home/controller/column_controller.dart';
import 'package:demo/utils/const/space_helper.dart';

import 'package:demo/features/auth/controller/auth_controller.dart';
import 'package:demo/features/home/widgets/stepper_graph.dart';
// import 'package:demo/utils/const/widgets/internet_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../utils/const/widgets/new_box.dart';
import 'model/home_model.dart';
// import '../Saving Tips/controller/saving_tips_controller.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepository = ref.watch(authControllerProvider);
    final colunRepository = ref.watch(columnGraphControllerProvider);
    List<GraphData> data = [];

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            vSpaceLarge,
            Row(
              children: [
                hSpaceMin,
                CircleAvatar(
                    radius: 5,
                    backgroundColor: Color.fromARGB(192, 246, 148, 2)),
                hSpaceMin,
                Text("H0y pris na")
              ],
            ),
            vSpaceMin,
            Text(
              '56 Ore',
              style: GoogleFonts.montserrat(
                  fontSize: 25, fontWeight: FontWeight.w500),
            ),
            vSpaceMedium,
            Text("Det er stor variasjon i dag"),
            vSpaceMedium,
            FutureBuilder(
                future: colunRepository.feacthColumnGraphData(),
                builder: (context, snapShot) {
                  if (snapShot.hasData) {
                    data = snapShot.data ?? [];
                  }
                  return NewBox(
                      child: SfCartesianChart(
                          title: ChartTitle(
                              text:
                                  'Strømprisvarsel neste 7 dager               >'),
                          primaryYAxis: NumericAxis(
                              isVisible: false,
                              //Hide the gridlines of y-axis
                              majorGridLines: MajorGridLines(width: 0),
                              //Hide the axis line of y-axis
                              axisLine: AxisLine(width: 0)),
                          plotAreaBorderWidth: 0,
                          borderColor: Colors.transparent,
                          backgroundColor: Colors.white,
                          enableSideBySideSeriesPlacement: false,
                          primaryXAxis: CategoryAxis(
                              title: AxisTitle(
                                text: "",
                              ),
                              majorGridLines: MajorGridLines(width: 0),
                              axisLine: AxisLine(width: 0)),
                          series: <ChartSeries>[
                        ColumnSeries<GraphData, String>(
                          color: Colors.amber,
                          dataSource: data,
                          xValueMapper: (GraphData data, _) => data.x,
                          yValueMapper: (GraphData data, _) => data.y,
                          pointColorMapper: (datum, index) => datum.color,
                        )
                      ]));
                }),
            vSpaceRegular,
            Text(
              'Price Graph',
              style: GoogleFonts.montserrat(
                  fontSize: 25, fontWeight: FontWeight.w500),
            ),
            vSpaceRegular,
            const StepperGraphWidget(),
            vSpaceMedium,
          ]),
    ))));
  }
}
