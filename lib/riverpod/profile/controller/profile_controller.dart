import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:demo/const/api_error_helper.dart';
import 'package:demo/model/model.dart';
import 'package:demo/riverpod/Saving%20Tips/model/savinr_tips_model.dart';
import 'package:demo/riverpod/auth/controller/auth_controller.dart';
import 'package:demo/riverpod/profile/widget/profile_edit_screen.dart';
import 'package:demo/riverpod/view/bottom_screen/bottum_navigation_screen.dart';
import 'package:demo/utils/routes/messenger.dart';
import 'package:demo/utils/routes/routes.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

ProfileModel? userProfile;
final profileControllerProvider = Provider((ref) => ProfileController());
final hasElCarStateProvider = StateProvider<bool>((ref) => false);
final wantPushWarning2StateProvider = StateProvider<bool>((ref) => false);
final hasSensorStateProvider = StateProvider<bool>((ref) => false);
final wantPushWarning1StateProvider = StateProvider<bool>((ref) => false);
final hasEatPumpStateProvider = StateProvider<bool>((ref) => false);
final hasSolarPanelStateProvider = StateProvider<bool>((ref) => false);

final profileEditDropdownListProvider = StateProvider<String>((ref) {
  return 'Select From List';
});
final profileEditZoneProvider = StateProvider<String>((ref) {
  return 'Select From List';
});

class ProfileController {
  List<SavingTips> savingTips = [];

  FirebaseAuth fb = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<dynamic> csvTable = [];
  List<String> dropdwonList = [];
  String? dropDownValue;
  String? zoneDropdowmValue;
  List<String> zoneDropdwonList = [
    "NO1",
    "NO2",
    "NO3",
    "NO4",
    "NO5",
  ];

  bool loader = false;
  final nameController = TextEditingController();
  final zoneController = TextEditingController();

  final yearlyCosumptionController = TextEditingController();
  final numberOfPepoleControler = TextEditingController();
  final powerCoinsController = TextEditingController();
  final powerPointController = TextEditingController();

  bool allBool = userProfile?.all ?? false;
  bool hasSensorBool = userProfile?.hasSensor ?? false;
  bool hasElCarBool = userProfile?.hasElCar ?? false;
  bool hasEatPumpBool = userProfile?.hasEatPump ?? false;
  bool hasSolarPanelBool = userProfile?.hasSolarPanel ?? false;
  bool wantPushWarning1Bool = userProfile?.wantPushWarning1 ?? false;
  bool wantPushWarning2Bool = userProfile?.wantPushWarning2 ?? false;

  changeDropDownValue(value) {
    log(value);

    dropDownValue = value;

    log(dropDownValue.toString());
  }

  changeZoneDropDownValue(value) {
    print(value);
    zoneDropdowmValue = value;
    print(zoneDropdowmValue);
  }

  hasSensorValueChange(value) {
    hasSensorBool = value;
  }

  hasElCarValueChange(value) {
    hasElCarBool = value;
  }

  allValueChange(value) {
    allBool = value;
  }

  hasEatPumpValueChange(value) {
    hasEatPumpBool = value;
  }

  hasSolarPanelValueChange(value) {
    hasSolarPanelBool = value;
  }

  wantPushWarning1ValueChange(value) {
    wantPushWarning1Bool = value;
  }

  wantPushWarning2ValueChange(value) {
    wantPushWarning2Bool = value;
  }

  Future<List<String>> fetchCSVData() async {
    try {
      final ref = FirebaseStorage.instance.ref().child('Stromselskap.csv');
      final url = await ref.getDownloadURL();

      final response = await Dio().get(url);
      csvTable = const CsvToListConverter().convert(response.data);
      if (csvTable.isNotEmpty) {
        dropdwonList.clear();

        for (var element in csvTable) {
          final value = element.toString();
          dropdwonList.add(value);
        }
      }
      return dropdwonList;
    } catch (e) {
      log(e.toString());
    }
    return dropdwonList;
  }

  updateUserProfileDetails(context) async {
    loader = true;
    String name;
    String yearlyConsmtn;
    String numberOfPepole;
    String powerCoins;
    String powerPoint;

    String zone;

    if (nameController.text.isEmpty) {
      name = userProfile!.name;
    } else {
      name = nameController.text;
    }
    zone = zoneDropdowmValue ?? userProfile!.pricezone;

    if (yearlyCosumptionController.text.isEmpty) {
      yearlyConsmtn = userProfile!.yearlyCosumption;
    } else {
      yearlyConsmtn = yearlyCosumptionController.text;
    }
    if (numberOfPepoleControler.text.isEmpty) {
      numberOfPepole = userProfile!.numberOfPepole;
    } else {
      numberOfPepole = numberOfPepoleControler.text;
    }
    if (powerCoinsController.text.isEmpty) {
      powerCoins = userProfile!.powerCoins;
    } else {
      powerCoins = powerCoinsController.text;
    }
    if (powerPointController.text.isEmpty) {
      powerPoint = userProfile!.powerPoint;
    } else {
      powerPoint = powerPointController.text;
    }

    log(name.toString());
    log(zone);
    log(yearlyConsmtn.toString());
    log(numberOfPepole);
    log(powerCoins);
    log(powerPoint);
    ProfileModel data = ProfileModel(
        all: hasElCarBool && hasSolarPanelBool && hasEatPumpBool ? true : false,
        email: fb.currentUser!.email.toString(),
        name: name.toString(),
        powerCompany: dropDownValue ?? userProfile!.powerCompany.toString(),
        pricezone: zone.toString(),
        yearlyCosumption: yearlyConsmtn,
        numberOfPepole: numberOfPepole,
        powerCoins: powerCoins,
        powerPoint: powerPoint,
        hasSensor: hasSensorBool,
        hasElCar: hasElCarBool,
        hasEatPump: hasEatPumpBool,
        hasSolarPanel: hasSolarPanelBool,
        wantPushWarning1: wantPushWarning1Bool,
        wantPushWarning2: wantPushWarning2Bool);
    if (allBool) {
      hasElCarBool = true;
      hasEatPumpBool = true;
      hasSolarPanelBool = true;
    }
    try {
      await db
          .collection('user')
          .doc(fb.currentUser!.uid)
          .collection('profile')
          .doc(fb.currentUser!.uid)
          .update(data.toJson());
      await AuthController()
          .updateZoneIdFromFirestore(zone, fb.currentUser!.email.toString());
      await AuthController().fetchZoneIdFromFirestore();
      Routes.pushreplace(screen: BottumNavigationScreen());
      clearController();

      loader = false;
    } catch (e) {
      Messenger.pop(msg: e.toString(), context: context);
      loader = false;
    }
  }

  clearController() {
    nameController.clear();
    yearlyCosumptionController.clear();
    numberOfPepoleControler.clear();
    powerCoinsController.clear();
    powerPointController.clear();
  }

  checkProfileDetails() async {
    final data = await getUserProfileDetails();
    if (data != null) {
      Routes.push(
          screen: ProfileEditScreen(
        data: data,
      ));
    } else {
      SnackBar(
        content: Text('Try again'),
      );
    }
  }

  Future<ProfileModel?> getUserProfileDetails() async {
    loader = true;
    try {
      await db
          .collection('user')
          .doc(fb.currentUser!.uid)
          .collection('profile')
          .doc(fb.currentUser!.uid)
          .get()
          .then((value) {
        userProfile = ProfileModel.fromJson(value.data()!);
        hasSensorBool = userProfile?.hasSensor ?? false;
        hasElCarBool = userProfile?.hasElCar ?? false;
        hasEatPumpBool = userProfile?.hasEatPump ?? false;
        hasSolarPanelBool = userProfile?.hasSolarPanel ?? false;
        wantPushWarning1Bool = userProfile?.wantPushWarning1 ?? false;
        wantPushWarning2Bool = userProfile?.wantPushWarning2 ?? false;
        loader = false;
      });
      return userProfile;
    } catch (e) {
      ErrorHandlerCode().status401(e);
      loader = false;
      return userProfile;
    }
  }
}
