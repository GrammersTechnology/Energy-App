import 'dart:developer';
import 'package:demo/const/api_error_helper.dart';
import 'package:demo/const/themes/colors.dart';
import 'package:demo/riverpod/Hva%20Koster/controller/hva_kaster.dart';
import 'package:demo/riverpod/chart/controller/chartcontroller.dart';
import 'package:demo/controller/home_controller.dart';
import 'package:demo/controller/profile_controller.dart';
import 'package:demo/model/model.dart';
import 'package:demo/routes/messenger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/auth_controller.dart';
import '../../routes/routes.dart';
import '../../screen/bottom_screen/bottum_navigation_screen.dart';
import '../auth/screen/loginscreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthControllerState extends StateNotifier<AuthState> {
  AuthControllerState()
      : super(AuthState(
            emailController: TextEditingController(),
            passwordController: TextEditingController()));

  FirebaseAuth fb = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  changeDropDownValue(String value) {
    state = state.copyWith(dropdowmValue: value);
  }

  Future<void> signup(BuildContext context) async {
    state = state.copyWith(loader: true);
    try {
      await fb.createUserWithEmailAndPassword(
          email: state.emailController.text.trim(),
          password: state.passwordController.text.trim());
      final data =
          UserModel(zone: state.dropdowmValue, email: fb.currentUser?.email);
      await db.collection("user").doc(fb.currentUser?.uid).set(data.toJson());
      await addUserProfileDetails(context);
      await saveAuthLocal();
      Routes.pushreplace(screen: BottumNavigationScreen());
      state = state.copyWith(loader: false);
    } catch (e) {
      clearLocalData();
      state = state.copyWith(loader: false);
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
    }
  }

  Future<void> signout(BuildContext context) async {
    try {
      await fb.signOut();
      state = state.copyWith(loader: false);
      state.emailController.clear();
      state.passwordController.clear();
      clearLocalData();
    } catch (e) {
      Messenger.pop(msg: e.toString(), context: context);
    }
  }

  Future<void> saveAuthLocal() async {
    final email = fb.currentUser?.email;
    final password = state.passwordController.text;
    final pref = await SharedPreferences.getInstance();
    await pref.setString('email', email.toString());
    await pref.setString('password', password.toString());
    await pref.setString('zone', state.dropdowmValue.toString().toUpperCase());
  }

  Future<void> clearLocalData() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('email');
    await pref.remove('password');
    await pref.remove('zone');
  }

  Future<void> getLocalData() async {
    final pref = await SharedPreferences.getInstance();
    state = state.copyWith(
      userEmail: pref.getString('email'),
      userPassword: pref.getString('password'),
    );
  }

  Future<void> cheackLocalData(BuildContext context) async {
    final pref = await SharedPreferences.getInstance();
    state = state.copyWith(
      userEmail: pref.getString('email'),
      userPassword: pref.getString('password'),
    );

    log(state.userEmail.toString());
    log(state.userPassword.toString());

    if (state.userEmail == null || state.userPassword == null) {
      Routes.pushreplace(screen: const LoginScreen());
    } else {
      await checkCurrentUser(context);
      final homeController = HomeController();
      homeController.getTips(context);
      homeController.fecthData(context);
    }
  }

  Future<void> checkCurrentUser(BuildContext context) async {
    User? user = fb.currentUser;
    if (user != null) {
      final profileController = ProfileController();
      final homeController = HomeController();
      final chartController = ChartController();
      final hvaController = HvaController();
      await profileController.getUserProfileDetails(context);

      homeController.feacthColumnGraphData(context);
      homeController.fecthData(context);
      homeController.getTips(context);
      chartController.getChartDetails();
      hvaController.getHvaDetails();

      Routes.pushreplace(screen: BottumNavigationScreen());
    } else {
      Routes.pushreplace(screen: const LoginScreen());
    }
  }

  Future<void> login(BuildContext context) async {
    state = state.copyWith(loader: true);
    try {
      await fb.signInWithEmailAndPassword(
          email: state.emailController.text.trim(),
          password: state.passwordController.text.trim());
      // saveAuthLocal();
      final email = fb.currentUser?.email;
      final password = state.passwordController.text;
      final pref = await SharedPreferences.getInstance();
      await pref.setString('email', email.toString());
      await pref.setString('password', password.toString());
      await fetchZoneIdFromFirestore();
      state = state.copyWith(loader: false);
      checkCurrentUser(context);
    } catch (e) {
      state = state.copyWith(loader: false);
      Messenger.pop(msg: e.toString(), context: context);
    }
  }

  Future<void> fetchZoneIdFromFirestore() async {
    state = state.copyWith(loader: true);
    final pref = await SharedPreferences.getInstance();
    try {
      db
          .collection('user')
          .doc(fb.currentUser?.uid)
          .collection("profile")
          .doc(fb.currentUser?.uid)
          .get()
          .then((value) {
        final data = ProfileModel.fromJson(value.data()!);
        String zoneId = data.pricezone.toString();
        zoneId = zoneId.substring(zoneId.length - 1);
        pref.setString('zone', zoneId.toString());
      }).catchError((error) {
        // Handle error
      });
    } catch (e) {
      ErrorHandlerCode().status401(e);
    } finally {
      state = state.copyWith(loader: false);
    }
  }

  Future<void> addUserProfileDetails(BuildContext context) async {
    state = state.copyWith(loader: true);
    ProfileModel data = ProfileModel(
        email: fb.currentUser!.email.toString(),
        name: '',
        powerCompany: "",
        pricezone: state.dropdowmValue.toString(),
        yearlyCosumption: "0",
        numberOfPepole: "0",
        powerCoins: "0",
        powerPoint: "0",
        hasSensor: false,
        hasElCar: false,
        hasEatPump: false,
        hasSolarPanel: false,
        wantPushWarning1: false,
        wantPushWarning2: false,
        all: false);

    try {
      await db
          .collection('user')
          .doc(fb.currentUser!.uid)
          .collection('profile')
          .doc(fb.currentUser!.uid)
          .set(data.toJson());
    } catch (e) {
      // Handle error
    } finally {
      state = state.copyWith(loader: false);
    }
  }

  Future<void> updateZoneIdFromFirestore(String zone, String email) async {
    state = state.copyWith(loader: true);
    try {
      final data = UserModel(zone: zone, email: email);
      await db.collection("user").doc(fb.currentUser?.uid).set(data.toJson());
    } catch (e) {
      // Handle error
    } finally {
      state = state.copyWith(loader: false);
    }
  }
}

class AuthState {
  TextEditingController emailController;
  TextEditingController passwordController;
  String? dropdowmValue;
  List<String> dropdwonList = ["NO1", "NO2", "NO3", "NO4", "NO5"];
  String? userEmail;
  String? userPassword;

  AuthState({
    required this.emailController,
    required this.passwordController,
    this.dropdowmValue,
    this.userEmail,
    this.userPassword,
  });

  AuthState copyWith({
    TextEditingController? emailController,
    TextEditingController? passwordController,
    String? dropdowmValue,
    bool? loader,
    String? userEmail,
    String? userPassword,
  }) {
    return AuthState(
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      dropdowmValue: dropdowmValue ?? this.dropdowmValue,
      userEmail: userEmail ?? this.userEmail,
      userPassword: userPassword ?? this.userPassword,
    );
  }
}
