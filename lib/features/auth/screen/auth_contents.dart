import 'package:demo/features/auth/controller/auth_controller.dart';
import 'package:demo/utils/const/space_helper.dart';
import 'package:demo/utils/const/widgets/byge-design-system/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthContents extends ConsumerWidget {
  const AuthContents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(authControllerProvider);
    ref.watch(stateUpdateProvider);
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Registerer\nbruker',
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
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
              controller.signInWithGoogle(context);
              ref.read(stateUpdateProvider.notifier).state =
                  controller.showContent;
              ref.read(stateUpdateProvider.notifier).state =
                  controller.profileverify;
              // Replace the current content with the "hello" content
            },
            color: const Color(0XFF404040),
          ),
          vSpaceSmall,
          BygePrimaryButton(
            label: "Register deg med Epost",
            labelColor: Colors.black,
            onPressed: () {
              controller.toggleShowContent();
              controller.toggleRegisterContent();
              ref.read(stateUpdateProvider.notifier).state =
                  controller.showContent;
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
                  controller.toggleShowContent();

                  controller.toggleLogin();
                  ref.read(stateUpdateProvider.notifier).state =
                      controller.showContent;
                  ref.read(stateUpdateProvider.notifier).state =
                      controller.isLogin;
                },
                child: const Text(
                  ' Logg inn',
                  style: TextStyle(color: Color.fromARGB(181, 0, 0, 0)),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
