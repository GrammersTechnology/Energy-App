import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:demo/features/navbar_widget.dart';
import 'package:demo/features/profile/model/profile_model.dart';
import 'package:demo/utils/const/api_error_helper.dart';
import 'package:demo/features/Saving%20Tips/model/savinr_tips_model.dart';
import 'package:demo/features/auth/controller/auth_controller.dart';
import 'package:demo/utils/routes/messenger.dart';
import 'package:demo/utils/routes/routes.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/controller/local_notification.dart';

ProfileModel? userProfile;
final profileControllerProvider = Provider((ref) => ProfileController());
final hasElCarStateProvider = StateProvider<bool>((ref) => false);
final hasSolarPanelStateProvider = StateProvider<bool>((ref) => false);
final oppvaskmaskinStateProvider = StateProvider<bool>((ref) => false);
final torketrommelStateProvider = StateProvider<bool>((ref) => false);
final vaskemaskinStateProvider = StateProvider<bool>((ref) => false);
final hasHeatPumpStateProvider = StateProvider<bool>((ref) => false);
final hasSensorStateProvider = StateProvider<bool>((ref) => false);
final wantPushWarning1StateProvider = StateProvider<bool>((ref) => false);

final profileCompanyDropdownListProvider = StateProvider<String>((ref) {
  return 'Select From List';
});
final profileEditZoneProvider = StateProvider<String>((ref) {
  return 'Select From List';
});

final mememberDropdownListProvider = StateProvider<String>((ref) {
  return 'Størrelse på boligen';
});

class ProfileController {
  List<SavingTips> savingTips = [];
  List<String> numberOfMembers = [
    'Under 50 kvm',
    '51 - 100 kvm',
    "101 - 150 kvm",
    "151 - 200 kvm",
    "over 200 kvm"
  ];
  String? membersDropdownValue;
  FirebaseAuth fb = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<dynamic> csvTable = [];
  List<String> dropdwonList = [];
  String? dropDownValue;
  String? zoneDropdowmValue;
  String? storreiseDropdownValue;
  List<String> zoneDropdwonList = [
    "NO1",
    "NO2",
    "NO3",
    "NO4",
    "NO5",
  ];

  bool loader = false;
  final countController = TextEditingController();
  final zoneController = TextEditingController();

  final yearlyCosumptionController = TextEditingController();
  final numberOfPepoleControler = TextEditingController();
  final powerCoinsController = TextEditingController();
  final powerPointController = TextEditingController();

  bool allBool = userProfile?.all ?? false;
  bool hasSensorBool = userProfile?.hasSensor ?? false;
  bool hasElCarBool = userProfile?.hasElCar ?? false;
  bool hasHeatPumpBool = userProfile?.hasEatPump ?? false;
  bool hasSolarPanelBool = userProfile?.hasSolarPanel ?? false;
  bool wantPushWarning1Bool = userProfile?.wantPushWarning ?? false;
  bool oppvaskmaskin = userProfile?.oppvaskmaskin ?? false;
  bool torketrommel = userProfile?.torketrommel ?? false;
  bool vaskemaskin = userProfile?.vaskemaskin ?? false;

// dropdawon list
  changeDropDownValue(value) {
    dropDownValue = value;
  }

  houseMemberDropdownValue(value) {
    membersDropdownValue = value;
  }

  changeZoneDropDownValue(value) {
    zoneDropdowmValue = value;
  }

// dropdawon list end

// check box list
  hasElCarValueChange(value) {
    hasElCarBool = value;
  }

  hasSolarPanelValueChange(value) {
    hasSolarPanelBool = value;
  }

  oppvaskmakinChange(value) {
    oppvaskmaskin = value;
  }

  torketommelChange(value) {
    torketrommel = value;
  }

  vaskemaskinChange(value) {
    vaskemaskin = value;
  }

  hasHeatPumpValueChange(value) {
    hasHeatPumpBool = value;
  }

  hasSensorValueChange(value) {
    hasSensorBool = value;
  }

  wantPushWarning1ValueChange(value) async {
    wantPushWarning1Bool = value;
    if (wantPushWarning1Bool) {
      await NotificationService().initNotification();
      NotificationService().morningNotification();
      NotificationService().afterNoonNotification();
    }
  }

  allValueChange(value) {
    allBool = value;
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

// update save saveStrom details
  saveStrom() async {
    loader = true;
    if (dropDownValue.toString().isEmpty &&
        zoneDropdowmValue.toString().isEmpty) {
      const SnackBar(
        content: Text(' Select your values'),
      );
    } else {
      if (userProfile == null) {
        log("nulll");
        log(dropDownValue.toString() + zoneDropdowmValue.toString());
      } else {
        ProfileModel data = ProfileModel(
            count: countController.text,
            storreise: storreiseDropdownValue ?? userProfile?.storreise ?? "",
            all: userProfile!.all,
            email: fb.currentUser!.email.toString(),
            powerCompany: dropDownValue ?? userProfile!.powerCompany,
            pricezone: zoneDropdowmValue ?? userProfile!.pricezone,
            hasSensor: userProfile!.hasSensor,
            hasElCar: userProfile!.hasElCar,
            hasEatPump: userProfile!.hasEatPump,
            hasSolarPanel: userProfile!.hasSolarPanel,
            wantPushWarning: userProfile!.wantPushWarning,
            oppvaskmaskin: userProfile!.oppvaskmaskin,
            torketrommel: userProfile!.torketrommel,
            vaskemaskin: userProfile!.vaskemaskin);
        log(data.toString());
      }

      // try {
      //   await db
      //       .collection('user')
      //       .doc(fb.currentUser!.uid)
      //       .collection('profile')
      //       .doc(fb.currentUser!.uid)
      //       .update(data.toJson());
      //   await AuthController().updateZoneIdFromFirestore(
      //       data.pricezone, fb.currentUser!.email.toString());
      //   await AuthController().fetchZoneIdFromFirestore();

      //   Routes.pushreplace(screen: const NavBarWidget());

      //   clearController();

      //   loader = false;
      // } catch (e) {
      //   // Messenger.pop(msg: e.toString(), context: context);
      //   loader = false;
      // }
    }
  }

  // Diit hjem saving

  dittHjemSave() {}

  updateUserProfiledittHjemSaveDetails(context) async {
    loader = true;

    ProfileModel data = ProfileModel(
        count: countController.text,
        storreise: storreiseDropdownValue ?? userProfile!.storreise,
        all:
            hasElCarBool && hasSolarPanelBool && hasHeatPumpBool ? true : false,
        email: fb.currentUser!.email.toString(),
        powerCompany: userProfile!.powerCompany.toString(),
        pricezone: userProfile!.pricezone,
        hasSensor: hasSensorBool,
        hasElCar: hasElCarBool,
        hasEatPump: hasHeatPumpBool,
        hasSolarPanel: hasSolarPanelBool,
        wantPushWarning: userProfile!.wantPushWarning,
        oppvaskmaskin: oppvaskmaskin,
        torketrommel: torketrommel,
        vaskemaskin: vaskemaskin);

    try {
      await db
          .collection('user')
          .doc(fb.currentUser!.uid)
          .collection('profile')
          .doc(fb.currentUser!.uid)
          .update(data.toJson());
      await AuthController().updateZoneIdFromFirestore(
          userProfile!.pricezone, fb.currentUser!.email.toString());
      await AuthController().fetchZoneIdFromFirestore();

      Routes.pushreplace(screen: const NavBarWidget());

      clearController();

      loader = false;
    } catch (e) {
      Messenger.pop(msg: e.toString(), context: context);
      loader = false;
    }
  }

  clearController() {
    countController.clear();
    yearlyCosumptionController.clear();
    numberOfPepoleControler.clear();
    powerCoinsController.clear();
    powerPointController.clear();
  }

  checkProfileDetails() async {
    final data = await getUserProfileDetails();
    if (data != null) {
      // Routes.push(
      //     screen: ProfileEditScreen(
      //   data: data,
      // ));
    } else {
      const SnackBar(
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
        hasHeatPumpBool = userProfile?.hasEatPump ?? false;
        hasSolarPanelBool = userProfile?.hasSolarPanel ?? false;
        wantPushWarning1Bool = userProfile?.wantPushWarning ?? false;
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
