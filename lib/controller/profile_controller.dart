import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:demo/model/model.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

ProfileModel? userProfile;

class ProfileController extends ChangeNotifier {
  FirebaseAuth fb = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<dynamic> csvTable = [];
  List<String> dropdwonList = [];
  final nameController = TextEditingController();
  final yearlyCosumptionController = TextEditingController();
  final numberOfPepoleControler = TextEditingController();
  final powerCoinsController = TextEditingController();
  final powerPointController = TextEditingController();
  String? dropdownValue;

  fetchCSVData() async {
    final ref = FirebaseStorage.instance.ref().child('Stromselskap.csv');
    final url = await ref.getDownloadURL();

    final response = await Dio().get(url);
    csvTable = CsvToListConverter().convert(response.data);
    if (csvTable.isNotEmpty) {
      dropdwonList.clear();

      for (var element in csvTable) {
        final value = element.toString();
        dropdwonList.add(value);
      }
      print(dropdwonList.first.toString());
    }
  }

  getProfileDagta() {
    db.doc('user').collection(fb.currentUser!.uid)
      ..doc('profile').get().then((value) {
        userProfile = ProfileModel.fromJson(value.data()!);
      });
  }

  addUserProfileDetails(bool hasSensor, bool hasElCar, bool hasEatPump,
      bool hasSolarPanel, bool wantPushWarning1, bool wantPushWarning2) async {
    final perf = await SharedPreferences.getInstance();

    final zone = perf.getString("zone");
    final ycc = yearlyCosumptionController.text;
    final yearlyCosumption = int.parse(ycc);
    final nop = numberOfPepoleControler.text;
    final numberOfPepole = int.parse(nop);
    final poc = powerCoinsController.text;
    final powerCoins = int.parse(poc);
    final pop = powerPointController.text;
    final powerPoint = int.parse(pop);

    ProfileModel data = ProfileModel(
        email: fb.currentUser!.email.toString(),
        name: nameController.text,
        powerCompany: dropdownValue ?? "",
        pricezone: zone.toString(),
        yearlyCosumption: yearlyCosumption,
        numberOfPepole: numberOfPepole,
        powerCoins: powerCoins,
        powerPoint: powerPoint,
        hasSensor: hasSensor,
        hasElCar: hasElCar,
        hasEatPump: hasEatPump,
        hasSolarPanel: hasSolarPanel,
        wantPushWarning1: wantPushWarning1,
        wantPushWarning2: wantPushWarning2);
    db
        .doc('user')
        .collection(fb.currentUser!.uid)
        .doc('profile')
        .update(data.toJson());
  }
}
