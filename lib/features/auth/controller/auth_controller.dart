import 'dart:developer';
import 'package:demo/features/Onboarding/view/onboarding.dart';
import 'package:demo/features/navbar_widget.dart';
import 'package:demo/features/profile/model/profile_model.dart';
import 'package:demo/utils/const/api_error_helper.dart';
import 'package:demo/utils/const/themes/colors.dart';
import 'package:demo/features/profile/controller/profile_controller.dart';
import 'package:demo/utils/routes/messenger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/routes/routes.dart';

final authControllerProvider = Provider((ref) => AuthController());
final stateUpdateProvider = StateProvider<bool>((ref) => false);

final zoneDropdownListProvider = StateProvider<String>((ref) {
  return 'Select From List';
});

class AuthController {
  FirebaseAuth fb = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String? userEmail;
  String? userPassword;
  String? dropdowmValue;
  List<String> dropdwonList = ["NO1", "NO2", "NO3", "NO4", "NO5"];
  bool registerFinished = false;
  bool isRegister = false;
  bool isLogin = false;
  bool showContent = true;
  bool loader = false;
  bool profileverify = false;

  changeDropDownValue(value) async {
    dropdowmValue = value;
  }

  void toggleRegisterContent() {
    isRegister = !isRegister;
  }

  void toggleShowContent() {
    showContent = !showContent;
  }

  void toggleLogin() {
    isLogin = !isLogin;
  }

  void toggelRegisterFinished() {
    registerFinished = !registerFinished;
  }

  void toggelProfileVerify() {
    profileverify = !profileverify;
  }

  // void isProcessCompleted() async {
  //   authProcessCompleted = !authProcessCompleted;
  //   final pref = await SharedPreferences.getInstance();
  //   pref.setBool('authProcessCompleted', true);
  // }

// onboard Cheaking
  checkOnboard() async {
    final pref = await SharedPreferences.getInstance();
    final zone = pref.getString('zone') ?? "null";
    print(zone);

    final email = pref.getString("email");
    final password = pref.getString("password");
    if (email != null &&
        email.isNotEmpty &&
        password != null &&
        password.isNotEmpty) {
      Routes.pushreplace(screen: const NavBarWidget());
    } else {
      final data = pref.getBool('Onboarding') ?? false;
      if (data && zone != "null") {
        Routes.pushreplace(screen: const NavBarWidget());
      } else {
        Routes.pushreplace(screen: const OnboardingScreen());
      }
    }
  }

  Future<bool> profileCheack() async {
    final pref = await SharedPreferences.getInstance();
    final zone = pref.getString('zone') ?? "null";

    final email = pref.getString("email");
    final password = pref.getString("password");
    if (email != null &&
        email.isNotEmpty &&
        password != null &&
        password.isNotEmpty &&
        zone != "null") {
      log("valewwwww hereer");
      return true;
    } else {
      log("valewwwww false");

      return false;
    }
  }

  void saveOnboarding(context) async {
    if (dropdowmValue == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Expanded(child: Text('Please Select From Dropdawon')),
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
    } else {
      final pref = await SharedPreferences.getInstance();
      await pref.setBool('Onboarding', true);
      await pref.setString("zone", dropdowmValue ?? "NO1");
      checkOnboard();
    }
  }

  signup(context) async {
    final pref = await SharedPreferences.getInstance();
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Expanded(child: Text('Please Enter your valied Details')),
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
    } else {
      final zoneData = pref.getString('zone');
      loader = true;
      try {
        await fb.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
        final data = UserModel(zone: zoneData, email: fb.currentUser?.email);
        await db
            .collection("user")
            .doc(fb.currentUser?.uid)
            // .collection('auth')
            .set(data.toJson());
        await addUserProfileDetails(context);

        registerFinished = true;
        loader = false;
      } catch (e) {
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
      }
    }
  }

  signout(context) async {
    try {
      await fb.signOut();
      emailController.clear();
      passwordController.clear();
      clearLocalData();
    } catch (e) {
      Messenger.pop(msg: e.toString(), context: context);
    }
  }

  saveAuthLocal() async {
    final pref = await SharedPreferences.getInstance();

    final email = fb.currentUser?.email;
    final password = passwordController.text;

    await pref.setString('email', email.toString());
    await pref.setString('password', password.toString());
    // pref.setBool("Onboarding", true);
    checkOnboard();
  }

  clearLocalData() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('email');
    await pref.remove('password');
    pref.setBool('authProcessCompleted', false);
    registerFinished = false;
    isRegister = false;
    isLogin = false;
    profileverify = false;
    showContent = true;
    // toggleShowContent();
    showContent = true;
    print(registerFinished.toString() +
        "666" +
        isRegister.toString() +
        "5555" +
        isLogin.toString() +
        "22" +
        showContent.toString() +
        "333");
  }

  Future<UserCredential?> signInWithGoogle(context) async {
    final pref = await SharedPreferences.getInstance();
    final zone = pref.getString("zone");
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleSignInAccount!.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await fb.signInWithCredential(credential);
      // Redirect to homepage
      if (userCredential.user != null) {
        log("${userCredential.user?.email} ----this is the goole usercredential user email.");
        final data = UserModel(zone: zone, email: userCredential.user?.email);
        await db
            .collection("user")
            .doc(fb.currentUser?.uid)
            // .collection('auth')
            .set(data.toJson());
        await addUserProfileDetails(context);
        profileverify = true;
        registerFinished = false;
        isRegister = false;
        isLogin = false;
        showContent = false;

        await pref.setString('email', userCredential.user?.email ?? '');
        await pref.setString('password', "123456");
        // cheackLocalData(context);
      }
      return userCredential;
    } catch (e) {
      log("Error signing in with Google: $e");
      // Show error message
      log(e.toString());
      Messenger.pop(msg: 'Failed to sign in with Google$e', context: context);
      return null;
    }
  }

  getLocalData() async {
    final pref = await SharedPreferences.getInstance();
    userEmail = pref.getString('email');
    userPassword = pref.getString('password');
  }

  // cheackLocalData(context) async {
  //   final pref = await SharedPreferences.getInstance();
  //   userEmail = pref.getString('email');
  //   userPassword = pref.getString('password');
  //   log(userEmail.toString());
  //   log(userPassword.toString());
  //   if (userEmail == null || userPassword == null) {
  //     Routes.pushreplace(screen: const LoginScreen());
  //   } else {
  //     checkCurrentUser(context);
  //   }
  // }

  Future<void> checkCurrentUser(context) async {
    User? user = fb.currentUser;
    if (user != null) {
      Routes.pushreplace(screen: NavBarWidget());
      ProfileController().getUserProfileDetails();
    } else {
      // Routes.pushreplace(screen:  NavBarWidget(profile: checkData,));
    }
  }

  login(context) async {
    loader = true;
    log(emailController.text);
    log(passwordController.text);
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Messenger.pop(msg: "Please Fill your Details", context: context);
    } else {
      try {
        await fb.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
        saveAuthLocal();
        final email = fb.currentUser?.email;
        final password = passwordController.text;
        final pref = await SharedPreferences.getInstance();
        await pref.setString('email', email.toString());
        await pref.setString('password', password.toString());
        await fetchZoneIdFromFirestore();
        loader = false;
        pref.setBool("Onboarding", true);
        checkCurrentUser(context);
        isRegister = false;
        isLogin = false;
        showContent = false;
      } catch (e) {
        loader = false;
        Messenger.pop(msg: e.toString(), context: context);
      }
    }
  }

  fetchZoneIdFromFirestore() async {
    loader = true;
    // Get the current user ID from Firebase Authentication
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

        // Access the zone ID field
        String zoneId = data.pricezone.toString();

        // zoneId = zoneId.substring(zoneId.length - 1);
        pref.setString('zone', zoneId.toString());

        loader = false;
      }).catchError((error) {
        loader = false;
      });
    } catch (e) {
      ErrorHandlerCode().status401(e);
    }
  }

  addUserProfileDetails(context) async {
    loader = true;
    final pref = await SharedPreferences.getInstance();
    final zone = pref.get("zone");
    ProfileModel data = ProfileModel(
        email: fb.currentUser!.email.toString(),
        count: '',
        powerCompany: "",
        pricezone: zone.toString(),
        storreise: '',
        hasSensor: false,
        hasElCar: false,
        hasHeatPump: false,
        hasSolarPanel: false,
        wantPushWarning: false,
        all: false,
        oppvaskmaskin: false,
        torketrommel: false,
        vaskemaskin: false);
    log(data.toJson().toString());
    try {
      log("message");
      await db
          .collection('user')
          .doc(fb.currentUser!.uid)
          .collection('profile')
          .doc(fb.currentUser!.uid)
          .set(data.toJson());

      loader = false;
    } catch (e) {
      loader = false;
      Messenger.pop(msg: e.toString(), context: context);
    }
  }

  updateZoneIdFromFirestore(String zone, String email) async {
    loader = true;
    try {
      final data = UserModel(zone: zone, email: email);
      await db.collection("user").doc(fb.currentUser?.uid).set(data.toJson());
      loader = false;
    } catch (e) {
      ErrorHandlerCode().status401(e);
    }
  }
}

class UserModel {
  String? email, zone, password;

  UserModel({this.password, required this.zone, required this.email});
  Map<String, dynamic> toJson() =>
      {"password": password, "email": email, "zone": zone};
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        zone: json["zone"], email: json["email"], password: json["password"]);
  }
}
