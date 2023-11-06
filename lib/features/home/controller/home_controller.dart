import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeControllerProvider = Provider((ref) => HomeController());
final showHomeControllerBoolStateProvider =
    StateProvider<List<bool>>((ref) => []);

//     final homeControllerProvider = Provider<HomeController>((ref) {
//   return HomeController();
// });

class HomeController {
  List<bool> toggelBool = [true, false, false];

  Future<List<bool>> changToggleButn(int index) async {
    if (index == 0) {
      toggelBool = [true, false, false];
      log("message1 $toggelBool");
      return toggelBool;
    } else if (index == 1) {
      toggelBool = [false, true, false];
      log("message2 $toggelBool");

      return toggelBool;
    } else {
      toggelBool = [false, false, true];
      log("message3 $toggelBool");

      return toggelBool;
    }
  }
}
