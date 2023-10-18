import 'package:demo/features/auth/controller/auth_controller.dart';
import 'package:demo/features/profile/view/profile_screen_updated.dart';
import 'package:demo/utils/const/space_helper.dart';
import 'package:demo/utils/const/widgets/byge-design-system/buttons/primary_button.dart';
import 'package:demo/utils/const/widgets/internet_connection.dart';
import 'package:demo/utils/controller/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationFinished extends ConsumerWidget {
  const AuthenticationFinished({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(stateUpdateProvider);
    return Expanded(
        child: ref.watch(authenticationProvider).when(
      data: (datas) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (datas.authProcessCompleted == false) ...[
            const Spacer(),
            const Text(
              'Registerering\nfullført',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            vSpaceSmall,
            const Text(
              'Opprettelsen av profilen var vellykket. ',
              style: TextStyle(fontSize: 16),
            ),
            vSpaceMedium,
            BygePrimaryButton(
              label: "RTilpass profil",
              onPressed: () {
                datas.isProcessCompleted();
                ref.read(stateUpdateProvider.notifier).state =
                    datas.authProcessCompleted;
              },
              color: const Color(0XFF404040),
            ),
            vSpaceMedium,
            const Center(
              child: Text(
                'Gjør dette senere, ta meg til forsiden',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ] else ...[
            const ProfilePage()
          ]
        ]);
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
