
import 'package:demo/riverpod/Saving%20Tips/controller/saving_tips_controller.dart';
import 'package:demo/riverpod/controller/auth_controller.dart';
import 'package:demo/riverpod/home/controller/column_controller.dart';

import 'package:demo/riverpod/chart/controller/chartcontroller.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Hva Koster/controller/hva_kaster.dart';
import 'controller/profile_controller.dart';
import 'home/controller/stepper_controller.dart';

// hva Provider
final hvaProvider = FutureProvider((ref) {
  final hvaRepository = ref.watch(userRepositeryProvider);
  return hvaRepository.getHvaDetails();
});


// column Controller

final columnProvider = FutureProvider((ref) {
  final columnRepository = ref.watch(columnGraphControllerProvider);
  return columnRepository.feacthColumnGraphData();
});

// stepper controller
final stepperProvider = FutureProvider((ref) {
  final stepperRepository = ref.watch(stepperGraphControllerProvider);
  return stepperRepository.fecthData();
});
final profileProvider = FutureProvider((ref) {
  final profileRepository = ref.watch(profileControllerProvider);
  return profileRepository.getUserProfileDetails();
});

//
final savingTipsProvider = FutureProvider((ref) {
  final savingTipsRepositary = ref.watch(saningTipsRepositeryProvider);
  return savingTipsRepositary.getTips();

final chartProvider = FutureProvider((ref) {
  final chartRepository = ref.watch(userChartProvider);
  return chartRepository.getChartDetails();
});
