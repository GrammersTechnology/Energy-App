import 'package:demo/riverpod/chart/controller/chartcontroller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Hva Koster/controller/hva_kaster.dart';

final hvaProvider = FutureProvider((ref) {
  final hvaRepository = ref.watch(userRepositeryProvider);
  return hvaRepository.getHvaDetails();
});

final chartProvider = FutureProvider((ref) {
  final chartRepository = ref.watch(userChartProvider);
  return chartRepository.getChartDetails();
});
