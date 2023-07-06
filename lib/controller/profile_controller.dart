import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:demo/model/model.dart';
import 'package:demo/routes/messenger.dart';
import 'package:demo/routes/routes.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import '../screen/bottom_screen/bottum_navigation_screen.dart';

ProfileModel? userProfile;
List<SavingTips> savingTips = [];

class ProfileController extends ChangeNotifier {
  FirebaseAuth fb = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<dynamic> csvTable = [];
  List<String> dropdwonList = [];
  String? dropDownValue;

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
    notifyListeners();
  }

  hasSensorValueChange(value) {
    hasSensorBool = value;
    notifyListeners();
  }

  hasElCarValueChange(value) {
    hasElCarBool = value;
    notifyListeners();
  }

  allValueChange(value) {
    allBool = value;
    notifyListeners();
  }

  hasEatPumpValueChange(value) {
    hasEatPumpBool = value;
    notifyListeners();
  }

  hasSolarPanelValueChange(value) {
    hasSolarPanelBool = value;
    notifyListeners();
  }

  wantPushWarning1ValueChange(value) {
    wantPushWarning1Bool = value;
    notifyListeners();
  }

  wantPushWarning2ValueChange(value) {
    wantPushWarning2Bool = value;
    notifyListeners();
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
        notifyListeners();
      }
      print(dropdwonList.first.toString());
      print(dropdwonList.last.toString());
    }
    notifyListeners();
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
    if (zoneController.text.isEmpty) {
      zone = userProfile!.pricezone;
    } else {
      zone = nameController.text;
    }
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
    print("object$name");
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
      notifyListeners();
    }
    try {
      await db
          .collection('user')
          .doc(fb.currentUser!.uid)
          .collection('profile')
          .doc(fb.currentUser!.uid)
          .update(data.toJson());
      Routes.pushreplace(screen: BottumNavigationScreen());
      clearController();
      loader = false;
      notifyListeners();
    } catch (e) {
      Messenger.pop(msg: e.toString(), context: context);
      loader = false;
      notifyListeners();
    }
  }

  clearController() {
    nameController.clear();
    zoneController.clear();
    yearlyCosumptionController.clear();
    numberOfPepoleControler.clear();
    powerCoinsController.clear();
    powerPointController.clear();
  }

  getUserProfileDetails(context) async {
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
        notifyListeners();
        loader = false;
        notifyListeners();
      });
    } catch (e) {
      Messenger.pop(msg: e.toString(), context: context);
      loader = false;
      notifyListeners();
    }
  }
}
