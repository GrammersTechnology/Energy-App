import 'dart:developer';

import 'package:demo/const/themes/colors.dart';
import 'package:demo/controller/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/screen/loginscreen.dart';
import '../routes/routes.dart';
import '../screen.dart/home_screen.dart';

class AuthController extends ChangeNotifier {
  FirebaseAuth fb = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? dropdowmValue;
  List<String> dropdwonList = ["NO1", "NO2", "NO3", "NO4", "NO5"];

  changeDropDownValue(value) {
    dropdowmValue = value;
    notifyListeners();
  }

  bool loader = false;

  signup(context) async {
    loader = true;
    try {
      await fb.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      final data = UserModel(zone: dropdowmValue, email: fb.currentUser?.email);
      await db.collection("user").add(data.toJson());
      await saveAuthLocal();
      Routes.pushreplace(screen: const HomeScreen());
      loader = false;
      notifyListeners();
    } catch (e) {
      log("--------------------error ${e.toString()}--------------------------");

      clearLocalData();
      loader = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Expanded(
                  child: Text(
                      'The email address is already in use by another account.')),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
                child: const Text(
                  'Close',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.primaryColor,
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
      notifyListeners();
    }
  }

  signout() async {
    await fb.signOut();
    emailController.clear();
    passwordController.clear();
  }

  saveAuthLocal() async {
    final email = fb.currentUser?.email;
    final password = passwordController.text;
    final pref = await SharedPreferences.getInstance();
    await pref.setString('email', email.toString());
    await pref.setString('password', password.toString());
    await pref.setString('zone', dropdowmValue.toString().toUpperCase());
  }

  clearLocalData() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('email');
    await pref.remove('password');
    await pref.remove('zone');
  }

  String? userEmail;
  String? userPassword;

  getLocalData() async {
    final pref = await SharedPreferences.getInstance();
    userEmail = pref.getString('email');
    userPassword = pref.getString('password');
    notifyListeners();
  }

  cheackLocalData(context) async {
    final pref = await SharedPreferences.getInstance();
    userEmail = pref.getString('email');
    userPassword = pref.getString('password');
    notifyListeners();
    log(userEmail.toString());
    log(userPassword.toString());
    if (userEmail == null || userPassword == null) {
      print("use name$userEmail");
      print("user password$userPassword");
      Routes.pushreplace(screen: const LoginScreen());
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
      // Routes.pushreplace(screen: HomeScreen());
      print("email founded");
      final homeController =
          Provider.of<HomeController>(context, listen: false);
      homeController.fecthData(context);
    }
  }

  login() async {
    await fb.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    notifyListeners();
    Routes.pushreplace(screen: const HomeScreen());
    saveAuthLocal();
  }
}

class UserModel {
  String? email, zone, password;

  UserModel({this.password, required this.zone, required this.email});
  Map<String, dynamic> toJson() =>
      {"password": password, "email": email, "zone": zone};
}
