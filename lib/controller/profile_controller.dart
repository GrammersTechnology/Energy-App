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
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/bottom_screen/bottum_navigation_screen.dart';

ProfileModel? userProfile;

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

  updateUserProfileDetails(
      bool hasSensor,
      bool hasElCar,
      bool hasEatPump,
      bool hasSolarPanel,
      bool wantPushWarning1,
      bool wantPushWarning2,
      context) async {
    loader = true;
    final perf = await SharedPreferences.getInstance();

    final zone = perf.getString("zone");

    ProfileModel data = ProfileModel(
        email: fb.currentUser!.email.toString(),
        name: nameController.text,
        powerCompany: dropDownValue ?? "",
        pricezone: zone.toString(),
        yearlyCosumption: yearlyCosumptionController.text,
        numberOfPepole: numberOfPepoleControler.text,
        powerCoins: powerCoinsController.text,
        powerPoint: powerPointController.text,
        hasSensor: hasSensor,
        hasElCar: hasElCar,
        hasEatPump: hasEatPump,
        hasSolarPanel: hasSolarPanel,
        wantPushWarning1: wantPushWarning1,
        wantPushWarning2: wantPushWarning2);

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

    // profileDocRef.update(data.toJson()).then((_) {
    //   print('Profile data updated successfully!');
    // }).catchError((error) {
    //   print('Failed to update profile data: $error');
    // });
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
        notifyListeners();
        log(userProfile!.email.toString());
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
