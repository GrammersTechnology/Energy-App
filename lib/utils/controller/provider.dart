import 'dart:developer';

import 'package:demo/features/auth/controller/auth_controller.dart';
import 'package:demo/features/home/controller/column_controller.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/Hva Koster/controller/hva_kaster.dart';
import '../../features/profile/controller/profile_controller.dart';
import '../../features/home/controller/stepper_controller.dart';

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
  return stepperRepository.stepperGrahData();
});
final profileProvider = FutureProvider((ref) {
  final profileRepository = ref.watch(profileControllerProvider);
  return profileRepository.getUserProfileDetails();
});

final profileEditProvider = FutureProvider((ref) {
  final profileEditRepository = ref.watch(profileControllerProvider);
  return profileEditRepository.fetchCSVData();
});
//
// final savingTipsProvider = FutureProvider((ref) {
//   final savingTipsRepositary = ref.watch(savingTipsRepositeryProvider);
//   return savingTipsRepositary.getTips();
// });

final authenticationProvider = FutureProvider((ref) {
  final authRepository = ref.watch(authControllerProvider);
  return authRepository;
});

final authCheackProvider = FutureProvider((ref) {
  final authRepository = ref.watch(authControllerProvider);
  authRepository.profileCheack();
});
