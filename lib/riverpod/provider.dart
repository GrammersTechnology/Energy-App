import 'package:demo/riverpod/controller/hva_kaster.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final hvaProvider = FutureProvider((ref) {
  final hvaRepository = ref.watch(userRepositeryProvider);
  return hvaRepository.getHvaDetails();
});
