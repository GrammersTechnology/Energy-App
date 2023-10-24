import 'package:demo/features/auth/controller/auth_controller.dart';
import 'package:demo/utils/const/space_helper.dart';
import 'package:demo/utils/const/widgets/byge-design-system/buttons/primary_button.dart';
import 'package:demo/utils/const/widgets/byge-design-system/input_fields/byge_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

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
          vSpaceMedium,
          const Text('Epost'),
          vSpaceSmall,
          BygeInputField(
            controller: controller.emailController,
            placeholder: 'Epost',
            placeholderColor: const Color.fromARGB(255, 124, 123, 123),
          ),
          vSpaceMedium,
          const Text('Passord'),
          vSpaceSmall,
          BygeInputField(
            controller: controller.passwordController,
            placeholder: 'Passord',
            placeholderColor: const Color.fromARGB(255, 124, 123, 123),
          ),
          vSpaceRegular,
          BygePrimaryButton(
            label: "Opprett bruker",
            onPressed: () {
              controller.signup(context);
              controller.toggleRegisterContent();
              controller.toggelRegisterFinished();
              ref.read(stateUpdateProvider.notifier).state =
                  controller.registerFinished;
              ref.read(stateUpdateProvider.notifier).state =
                  controller.isRegister;
            },
            color: const Color(0XFF404040),
          ),
        ],
      ),
    );
  }
}
