import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:demo/const/api_error_helper.dart';
import 'package:demo/model/model.dart';
import 'package:demo/riverpod/Saving%20Tips/model/savinr_tips_model.dart';
import 'package:demo/riverpod/view/bottom_screen/bottum_navigation_screen.dart';
import 'package:demo/routes/messenger.dart';
import 'package:demo/routes/routes.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod/riverpod.dart';

ProfileModel? userProfile;
List<SavingTips> savingTips = [];
final profileControllerProvider = Provider((ref) => ProfileController());

class ProfileController {
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
    dropDownValue = value;
  }

  changeZoneDropDownValue(value) {
    zoneDropdowmValue = value;
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

  fetchCSVData() async {
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
      // await AuthController()
      //     .updateZoneIdFromFirestore(zone, fb.currentUser!.email.toString());
      // await AuthController().fetchZoneIdFromFirestore();
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
        hasSensorBool = userProfile!.hasSensor;
        hasElCarBool = userProfile!.hasElCar;
        hasEatPumpBool = userProfile!.hasEatPump;
        hasSolarPanelBool = userProfile!.hasSolarPanel;
        wantPushWarning1Bool = userProfile!.wantPushWarning1;
        wantPushWarning2Bool = userProfile!.wantPushWarning2;
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
