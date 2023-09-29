import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Hva Koster/controller/hva_kaster.dart';

final hvaProvider = FutureProvider((ref) {
  final hvaRepository = ref.watch(userRepositeryProvider);
  return hvaRepository.getHvaDetails();
});
