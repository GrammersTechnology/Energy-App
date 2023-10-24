// ignore_for_file: must_be_immutable

import 'package:demo/features/home/controller/column_controller.dart';
import 'package:demo/features/home/widgets/column_graphwidget.dart';
import 'package:demo/features/home/widgets/detailed_graph.dart';
import 'package:demo/utils/const/space_helper.dart';

import 'package:demo/features/home/widgets/stepper_graph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../utils/const/widgets/new_box.dart';
import 'controller/stepper_controller.dart';
import 'model/home_model.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});
  List<GraphData> columnData = [];
  List<GraphData> stepprData = [];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colunRepository = ref.watch(columnGraphControllerProvider);
    final stepperRepository = ref.watch(stepperGraphControllerProvider);

    final bool columnBarState = ref.watch(showColumnBarBoolStateProvider);
    final bool stepperBarState = ref.watch(showStepperBarBoolStateProvider);

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          if (colunRepository.showColumnBool)
            DetailedGraph(
                onPress: () {
                  colunRepository.changeColumnBarBool();
                  ref.read(showColumnBarBoolStateProvider.notifier).state =
                      !columnBarState;
                },
                details: "Hoy pris og mye variasjon gejennom dagen",
                iconDetails: "Spotpris 1 dag ",
                title: "Strømpris",
                child: const ColumnGraphWidget())
          else if (stepperRepository.showStepparBool)
            DetailedGraph(
                onPress: () {
                  stepperRepository.changeStepperBarBool();
                  ref.read(showStepperBarBoolStateProvider.notifier).state =
                      !stepperBarState;
                },
                iconDetails: "Estimert gj.snittspris neste 7 dager",
                details: "",
                title: "Strømprisvarrsel",
                child: const StepperGraphWidget())
          else
            SizedBox(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    vSpaceLarge,
                    const Row(
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
                    const Text("Det er stor variasjon i dag"),
                    vSpaceMedium,
                    FutureBuilder(
                        future: stepperRepository.fecthData(),
                        builder: (context, snapShot) {
                          if (snapShot.hasData) {
                            stepprData = snapShot.data ?? [];
                          } else if (snapShot.hasError) {
                            return const NewBox(
                              child: SizedBox(
                                height: 250,
                                child: Center(child: Text("Somthing Wrong")),
                              ),
                            );
                          } else if (snapShot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return GestureDetector(
                            onTap: () {
                              stepperRepository.changeStepperBarBool();
                              ref
                                  .read(
                                      showStepperBarBoolStateProvider.notifier)
                                  .state = !stepperBarState;
                            },
                            child: NewBox(
                                child: stepprData.isNotEmpty
                                    ? SfCartesianChart(
                                        title: ChartTitle(
                                            text:
                                                'Strømprisvarsel neste 7 dager         >'),
                                        plotAreaBorderWidth: 0,
                                        borderColor: Colors.transparent,
                                        primaryYAxis: NumericAxis(
                                            isVisible: false,
                                            //Hide the gridlines of y-axis
                                            majorGridLines:
                                                const MajorGridLines(width: 0),
                                            //Hide the axis line of y-axis
                                            axisLine: const AxisLine(width: 0)),
                                        primaryXAxis: CategoryAxis(
                                            title: AxisTitle(
                                              text: "",
                                            ),
                                            majorGridLines:
                                                const MajorGridLines(width: 0),
                                            axisLine: const AxisLine(width: 0)),
                                        series: <ChartSeries>[
                                          StepLineSeries<GraphData, String>(
                                            dataSource: stepprData,
                                            xValueMapper:
                                                (GraphData sales, _) =>
                                                    sales.x.toString(),
                                            yValueMapper:
                                                (GraphData sales, _) => sales.y,
                                            // dataLabelSettings: DataLabelSettings(isVisible: true)
                                          )
                                        ],
                                      )
                                    : const Center(
                                        child:
                                            Text("Data is Not Available now"),
                                      )),
                          );
                        }),
                    vSpaceRegular,
                    FutureBuilder(
                        future: colunRepository.feacthColumnGraphData(),
                        builder: (context, snapShot) {
                          if (snapShot.hasData) {
                            columnData = snapShot.data ?? [];
                          } else if (snapShot.hasError) {
                            return const Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: NewBox(
                                child: SizedBox(
                                  height: 250,
                                  child: Center(child: Text("Somthing Wrong")),
                                ),
                              ),
                            );
                          } else if (snapShot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return GestureDetector(
                            onTap: () {
                              colunRepository.changeColumnBarBool();
                              ref
                                  .read(showColumnBarBoolStateProvider.notifier)
                                  .state = !columnBarState;
                            },
                            child: NewBox(
                                child: columnData.isNotEmpty
                                    ? SfCartesianChart(
                                        title: ChartTitle(
                                            text:
                                                'Strømprisvarsel neste 7 dager         >'),
                                        primaryYAxis: NumericAxis(
                                            isVisible: false,
                                            //Hide the gridlines of y-axis
                                            majorGridLines:
                                                const MajorGridLines(width: 0),
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
                                            majorGridLines:
                                                const MajorGridLines(width: 0),
                                            axisLine: const AxisLine(width: 0)),
                                        series: <ChartSeries>[
                                            ColumnSeries<GraphData, String>(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              color: Colors.amber,
                                              dataSource: columnData,
                                              xValueMapper:
                                                  (GraphData data, _) => data.x,
                                              yValueMapper:
                                                  (GraphData data, _) => data.y,
                                              pointColorMapper:
                                                  (datum, index) => datum.color,
                                            )
                                          ])
                                    : const Center(
                                        child:
                                            Text("Data is not Available now"),
                                      )),
                          );
                        }),
                    vSpaceRegular,
                  ]),
            ),
        ],
      ),
    ))));
  }
}
