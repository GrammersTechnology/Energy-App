import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/riverpod/Saving%20Tips/model/savinr_tips_model.dart';
import 'package:demo/riverpod/profile/controller/profile_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final saningTipsRepositeryProvider = Provider((ref) => SavingTipsController());

class SavingTipsController {
  FirebaseAuth fb = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<SavingTips> savingTips = [];

  Future<List<SavingTips>> getTips() async {
    // final controller = ref.watch(profileControllerProvider);

    // final controller = Provider.of<ProfileController>(context, listen: false);
    await db.collection("savings_tips").get().then((value) {
      final data = value.docs;
      List<SavingTips> tempData = [];
      log(data.toString() + "ccccccccccccccccc");

      if (data.isNotEmpty) {
        for (var element in data) {
          final singleData = SavingTips(
              readmoretxt: element.data()['ReadMoreTxt'],
              savingstips: element.data()['SavingsTips'],
              allItems: element.data()['All'],
              elCars: element.data()['ElCar'],
              heatPumps: element.data()['HeatPump'],
              solarPanels: element.data()['SolarPanels'],
              dateTIme: element.data()['TimeDate']);

          tempData.add(singleData);
        }
        savingTips.clear();

        if (tempData.isNotEmpty) {
          if (ProfileController().hasElCarBool &&
              ProfileController().hasEatPumpBool &&
              ProfileController().hasSolarPanelBool) {
            for (var element in tempData) {
              if (element.allItems == true) {
                log(savingTips.toString());

                savingTips.add(element);
              }
            }
          } else if (ProfileController().hasElCarBool) {
            for (var element in tempData) {
              if (element.elCars == true) {
                savingTips.add(element);
                log(savingTips.first.savingstips.toString());
              }
            }
          } else if (ProfileController().hasEatPumpBool) {
            for (var element in tempData) {
              if (element.heatPumps == true) {
                savingTips.add(element);
                log(savingTips.first.savingstips.toString());
              }
            }
          } else if (ProfileController().hasSolarPanelBool) {
            for (var element in tempData) {
              if (element.solarPanels == true) {
                savingTips.add(element);
                log(savingTips.first.savingstips.toString());
              }
            }
          }
        } else {
          savingTips.clear();
          return savingTips;
        }
        //sorting//
        if (savingTips.length > 1) {
          for (var element in savingTips) {
            DateTime date = DateTime.parse(element.dateTIme.toString());
            log(date.runtimeType.toString());
          }
          savingTips
              .sort((a, b) => a.dateTIme.toString().compareTo(b.dateTIme));
          return savingTips;
        }
        return savingTips;
      }
      log("eeeeeeeeeeeeeeeeeeeeeee");
      log(savingTips.length.toString());

      return savingTips;
    }).catchError((error) {
      return savingTips;
    });
    return savingTips;
  }

  // getTips(context, WidgetRef ref) async {
  //   final controller = ref.watch(profileControllerProvider);

  //   // final controller = Provider.of<ProfileController>(context, listen: false);
  //   await db.collection("savings_tips").get().then((value) {
  //     final data = value.docs;
  //     List<SavingTips> tempData = [];
  //     log(data.toString() + "ccccccccccccccccc");

  //     if (data.isNotEmpty) {
  //       for (var element in data) {
  //         final singleData = SavingTips(
  //             readmoretxt: element.data()['ReadMoreTxt'],
  //             savingstips: element.data()['SavingsTips'],
  //             allItems: element.data()['All'],
  //             elCars: element.data()['ElCar'],
  //             heatPumps: element.data()['HeatPump'],
  //             solarPanels: element.data()['SolarPanels'],
  //             dateTIme: element.data()['TimeDate']);

  //         tempData.add(singleData);
  //       }
  //       savingTips.clear();

  //       if (tempData.isNotEmpty) {
  //         if (controller.hasElCarBool &&
  //             controller.hasEatPumpBool &&
  //             controller.hasSolarPanelBool) {
  //           for (var element in tempData) {
  //             if (element.allItems == true) {
  //               log(savingTips.toString());

  //               savingTips.add(element);
  //             }
  //           }
  //         } else if (controller.hasElCarBool) {
  //           for (var element in tempData) {
  //             if (element.elCars == true) {
  //               savingTips.add(element);
  //               log(savingTips.first.savingstips.toString());
  //             }
  //           }
  //         } else if (controller.hasEatPumpBool) {
  //           for (var element in tempData) {
  //             if (element.heatPumps == true) {
  //               savingTips.add(element);
  //               log(savingTips.first.savingstips.toString());
  //             }
  //           }
  //         } else if (controller.hasSolarPanelBool) {
  //           for (var element in tempData) {
  //             if (element.solarPanels == true) {
  //               savingTips.add(element);
  //               log(savingTips.first.savingstips.toString());
  //             }
  //           }
  //         }
  //       } else {
  //         savingTips.clear();
  //       }
  //       //sorting//
  //       if (savingTips.length > 1) {
  //         for (var element in savingTips) {
  //           DateTime date = DateTime.parse(element.dateTIme.toString());
  //           log(date.runtimeType.toString());
  //         }
  //         savingTips
  //             .sort((a, b) => a.dateTIme.toString().compareTo(b.dateTIme));
  //       }
  //     }

  //     // log(savingTips.length.toString());
  //   }).catchError((error) {});
  // }
}
