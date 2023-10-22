import 'package:demo/features/auth/controller/auth_controller.dart';
import 'package:demo/features/auth/screen/authentication_update.dart';
import 'package:demo/utils/const/widgets/byge-design-system/input_fields/byge_input_field.dart';
import 'package:demo/utils/const/widgets/internet_connection.dart';
import 'package:demo/utils/controller/provider.dart';
import 'package:flutter/material.dart';
import 'package:demo/utils/const/space_helper.dart';
import 'package:demo/utils/const/widgets/byge-design-system/buttons/primary_button.dart';
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
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Registerer\nbruker',
                              style: TextStyle(
                                  fontSize: 48, fontWeight: FontWeight.bold),
                            ),
                            vSpaceSmall,
                            const Text(
                              'Register bruker for å lage en tilpasse din\nprofil.',
                              style: TextStyle(fontSize: 16),
                            ),
                            vSpaceMedium,
                            BygePrimaryButton(
                              label: "Register deg med Goolge",
                              onPressed: () {
                                // Replace the current content with the "hello" content
                              },
                              color: const Color(0XFF404040),
                            ),
                            vSpaceSmall,
                            BygePrimaryButton(
                              label: "Register deg med Epost",
                              labelColor: Colors.black,
                              onPressed: () {
                                controller.toggleRegisterContent();
                                ref.read(stateUpdateProvider.notifier).state =
                                    controller.showLoginContent;
                                ref.read(stateUpdateProvider.notifier).state =
                                    controller.isRegister;
                              },
                              color: Colors.white,
                              borderColor: Colors.black,
                            ),
                            vSpaceMin,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Har du allerede bruker?'),
                                TextButton(
                                  onPressed: () {
                                    controller.toggleLoginContent();
                                    ref
                                        .read(stateUpdateProvider.notifier)
                                        .state = controller.showLoginContent;
                                    ref
                                        .read(stateUpdateProvider.notifier)
                                        .state = controller.isLogin;
                                  },
                                  child: const Text(
                                    ' Logg inn',
                                    style: TextStyle(
                                        color: Color.fromARGB(181, 0, 0, 0)),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ] else if (controller.showLoginContent == false &&
                        controller.isLogin == true) ...[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Logg inn',
                              style: TextStyle(
                                  fontSize: 48, fontWeight: FontWeight.bold),
                            ),
                            vSpaceMedium,
                            const Text('Epost'),
                            vSpaceSmall,
                            BygeInputField(
                              controller: controller.emailController,
                              placeholder: 'Epost',
                              placeholderColor:
                                  const Color.fromARGB(255, 124, 123, 123),
                            ),
                            vSpaceMedium,
                            const Text('Passord'),
                            vSpaceSmall,
                            BygeInputField(
                              controller: controller.passwordController,
                              placeholder: 'Passord',
                              placeholderColor:
                                  const Color.fromARGB(255, 124, 123, 123),
                            ),
                            vSpaceRegular,
                            BygePrimaryButton(
                              label: "Logg inn",
                              onPressed: () {},
                              color: const Color(0XFF404040),
                            ),
                          ],
                        ),
                      ),
                    ] else if (controller.showLoginContent == false &&
                        controller.isRegister == true) ...[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Registerer\nbruker',
                              style: TextStyle(
                                  fontSize: 48, fontWeight: FontWeight.bold),
                            ),
                            vSpaceMedium,
                            const Text('Epost'),
                            vSpaceSmall,
                            BygeInputField(
                              controller: controller.emailController,
                              placeholder: 'Epost',
                              placeholderColor:
                                  const Color.fromARGB(255, 124, 123, 123),
                            ),
                            vSpaceMedium,
                            const Text('Passord'),
                            vSpaceSmall,
                            BygeInputField(
                              controller: controller.passwordController,
                              placeholder: 'Passord',
                              placeholderColor:
                                  const Color.fromARGB(255, 124, 123, 123),
                            ),
                            vSpaceRegular,
                            BygePrimaryButton(
                              label: "Opprett bruker",
                              onPressed: () {
                                // controller.login(context);
                                // ref.read(stateUpdateProvider.notifier).state =
                                //     controller.isLogin;
                                controller.showLoginContent = false;
                                controller.isRegister = false;
                                controller.isLogin = false;
                                ref.read(stateUpdateProvider.notifier).state =
                                    controller.showLoginContent;
                                ref.read(stateUpdateProvider.notifier).state =
                                    controller.isRegister;
                                ref.read(stateUpdateProvider.notifier).state =
                                    controller.isLogin;
                              },
                              color: const Color(0XFF404040),
                            ),
                          ],
                        ),
                      ),
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
