import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/riverpod/Saving%20Tips/model/savinr_tips_model.dart';
import 'package:demo/riverpod/profile/controller/profile_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final savingTipsRepositeryProvider = Provider((ref) => SavingTipsController());

class SavingTipsController {
  FirebaseAuth fb = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<SavingTips> savingTipsList = [];

  Future<List<SavingTips>> getTips() async {
    await db.collection("savings_tips").get().then((value) {
      final data = value.docs;
      List<SavingTips> tempData = [];

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
          log(singleData.allItems.toString() + "herere");
          tempData.add(singleData);
        }
        savingTipsList.clear();

        if (tempData.isNotEmpty) {
          // print("not empty temp");
          if (ProfileController().hasElCarBool &&
              ProfileController().hasEatPumpBool &&
              ProfileController().hasSolarPanelBool) {
            // log("hasElCarBool+hasEatPumpBool+hasSolarPanelBool");
            for (var element in tempData) {
              if (element.allItems == true) {
                log(savingTipsList.toString());

                savingTipsList.add(element);
              }
            }
          } else if (ProfileController().hasElCarBool) {
            log("hasElCarBool");

            for (var element in tempData) {
              if (element.elCars == true) {
                savingTipsList.add(element);
                log(savingTipsList.first.savingstips.toString());
              }
            }
          } else if (ProfileController().hasEatPumpBool) {
            log("hasEatPumpBool");

            for (var element in tempData) {
              if (element.heatPumps == true) {
                savingTipsList.add(element);
                log(savingTipsList.first.savingstips.toString());
              }
            }
          } else if (ProfileController().hasSolarPanelBool) {
            log("hasSolarPanelBool");

            for (var element in tempData) {
              if (element.solarPanels == true) {
                savingTipsList.add(element);
                log(savingTipsList.first.savingstips.toString());
              }
            }
          }
        } else {
          savingTipsList.clear();
          return savingTipsList;
        }
        //sorting//
        if (savingTipsList.length > 1) {
          for (var element in savingTipsList) {
            DateTime date = DateTime.parse(element.dateTIme.toString());
            log(date.runtimeType.toString());
          }
          savingTipsList
              .sort((a, b) => a.dateTIme.toString().compareTo(b.dateTIme));
        }
        return savingTipsList;
      }
      log("eeeeeeeeeeeeeeeeeeeeeee");
      log(savingTipsList.length.toString());

      return savingTipsList;
    }).catchError((error) {
      return savingTipsList;
    });
    return savingTipsList;
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
