import 'package:demo/features/auth/controller/auth_controller.dart';
import 'package:demo/features/auth/screen/auth_contents.dart';
import 'package:demo/features/auth/screen/auth_finish.dart';
import 'package:demo/features/auth/screen/login.dart';
import 'package:demo/features/auth/screen/register.dart';
import 'package:demo/utils/const/widgets/internet_connection.dart';
import 'package:demo/utils/controller/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileAuthentication extends ConsumerWidget {
  const ProfileAuthentication({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(authControllerProvider);
    ref.watch(stateUpdateProvider);
    return Scaffold(
        appBar: (controller.isRegister == true || controller.isLogin == true) &&
                controller.showLoginContent == false
            ? AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                    onPressed: () {
                      controller.showLoginContent = true;
                      controller.isRegister = false;
                      controller.isLogin = false;
                      ref.read(stateUpdateProvider.notifier).state =
                          controller.showLoginContent;
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
        body: ref.watch(authenticationProvider).when(
          data: (datas) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Column(
                  children: [
                    if (controller.showLoginContent) ...[
                      const AuthContents(),
                    ] else if (controller.showLoginContent == false &&
                        controller.isLogin == true) ...[
                      const LoginPage(),
                    ] else if (controller.showLoginContent == false &&
                        controller.isRegister == true) ...[
                      const RegisterScreen(),
                    ] else ...[
                      const AuthenticationFinished()
                    ],
                  ],
                ),
              ),
            );
          },
          error: (error, stackTrace) {
            return const SafeArea(child: InternetChecking());
          },
          loading: () {
            return const SafeArea(
                child: Center(
              child: CircularProgressIndicator(),
            ));
          },
        ));
  }
}
