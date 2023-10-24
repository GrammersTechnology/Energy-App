import 'dart:developer';

import 'package:demo/features/auth/controller/auth_controller.dart';
import 'package:demo/features/auth/screen/auth_contents.dart';
import 'package:demo/features/auth/screen/auth_finish.dart';
import 'package:demo/features/auth/screen/login.dart';
import 'package:demo/features/auth/screen/register.dart';
import 'package:demo/features/profile/view/profile_screen_updated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileAuthentication extends ConsumerWidget {
  const ProfileAuthentication({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(authControllerProvider);
    ref.watch(stateUpdateProvider);
    log(controller.showContent.toString() + '-----------------------');
    return Scaffold(
        appBar: (controller.isRegister == true || controller.isLogin == true) &&
                controller.showContent == false
            ? AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                    onPressed: () {
                      controller.showContent = true;
                      controller.isRegister = false;
                      controller.isLogin = false;
                      ref.read(stateUpdateProvider.notifier).state =
                          controller.showContent;
                      ref.read(stateUpdateProvider.notifier).state =
                          controller.isRegister;
                      ref.read(stateUpdateProvider.notifier).state =
                          controller.isLogin;
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.black,
                      size: 17,
                      weight: 900,
                    )),
                title: const Text(
                  'Tilbake',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              )
            : AppBar(
                backgroundColor: const Color.fromARGB(0, 253, 233, 233),
                elevation: 0,
              ),
        body: FutureBuilder(
            future: controller.profileCheack(),
            builder: (context, snapShot) {
              log(controller.profileverify.toString() +
                  "verifyyyy++++++++++++++++++");

              if (snapShot.hasData) {
                controller.profileverify = snapShot.data ?? false;
              }
              if (snapShot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return controller.profileverify == true
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            ProfilePage(),
                          ],
                        ),
                      ),
                    )
                  : SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 20),
                        child: Column(
                          children: [
                            if (controller.showContent) ...[
                              const AuthContents(),
                            ] else if (controller.isLogin) ...[
                              const LoginPage(),
                            ] else if (controller.isRegister) ...[
                              const RegisterScreen(),
                            ] else if (controller.registerFinished) ...[
                              const AuthenticationFinished()
                            ]
                          ],
                        ),
                      ),
                    );
            }));
  }
}
