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
        appBar: controller.loginCompleted == false &&
                controller.showLoginContent == false
            ? AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                    onPressed: () {
                      controller.showLoginContent = true;
                      ref.read(stateUpdateProvider.notifier).state =
                          controller.showLoginContent;
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
                                controller.toggleContent();
                                ref.read(stateUpdateProvider.notifier).state =
                                    controller.showLoginContent;
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
                                  onPressed: () {},
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
                    ] else ...[
                      if (controller.loginCompleted == false) ...[
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
                              const BygeInputField(
                                placeholder: 'Epost',
                                placeholderColor:
                                    Color.fromARGB(255, 124, 123, 123),
                              ),
                              vSpaceMedium,
                              const Text('Passord'),
                              vSpaceSmall,
                              const BygeInputField(
                                placeholder: 'Passord',
                                placeholderColor:
                                    Color.fromARGB(255, 124, 123, 123),
                              ),
                              vSpaceRegular,
                              BygePrimaryButton(
                                label: "Register deg med Goolge",
                                onPressed: () {
                                  controller.finishLogin();
                                  ref.read(stateUpdateProvider.notifier).state =
                                      controller.loginCompleted;
                                },
                                color: const Color(0XFF404040),
                              ),
                            ],
                          ),
                        ),
                      ] else ...[
                        const AuthenticationFinished()
                      ]
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
