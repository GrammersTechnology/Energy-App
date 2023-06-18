import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/home_services.dart';

class HomeController extends ChangeNotifier {
  List result = [];
  bool loader = false;
  fecthData(
    context,
  ) async {
    final perf = await SharedPreferences.getInstance();

    final zone = perf.getString("zone");
    await HomeScreenServicesScreen().dataDetailsApi(context, 'NO2');
    // if (data?.data != null) {
    //   print(data.toString());
    // }
    print(result.length);

    if (result.isNotEmpty) {
      for (int i = 0; i < result.length; i++) {
        final starteDate = result[i]['time_start'];
        final endDate = result[i]['time_end'];
        DateTime dateTimeStart = DateTime.parse(starteDate);
        DateTime dateTimeEnd = DateTime.parse(endDate);
        result[i]['time_start'] =
            "${dateTimeStart.day}-${dateTimeStart.month}-${dateTimeStart.year}";
        result[i]['time_end'] =
            "${dateTimeEnd.day}-${dateTimeEnd.month}-${dateTimeEnd.year}";
      }
    }
    loader = false;
  }

  void fetchZoneIdFromFirestore() {
    // Get the current user ID from Firebase Authentication
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {
      FirebaseFirestore.instance
          .collection('user')
          .doc(userId)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          Map<String, dynamic> data =
              documentSnapshot.data() as Map<String, dynamic>;

          // Access the zone ID field
          String? zoneId = data['zone'];

          if (zoneId != null) {
            // Use the zone ID here
            print('Zone ID: $zoneId');
          } else {
            print('Zone ID not found for the user.');
          }
        } else {
          print('User document not found.');
        }
      }).catchError((error) {
        print('Error retrieving data: $error');
      });
    } else {
      print('User is not authenticated.');
    }
  }
}
