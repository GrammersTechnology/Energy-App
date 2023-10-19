import 'package:demo/features/auth/controller/auth_controller.dart';
import 'package:demo/features/chart/controller/chartcontroller.dart';
import 'package:demo/features/profile/controller/profile_controller.dart';
import 'package:demo/utils/const/space_helper.dart';
import 'package:demo/utils/const/widgets/byge-design-system/buttons/primary_button.dart';
import 'package:demo/utils/const/widgets/byge-design-system/buttons/toggle_button.dart';
import 'package:demo/utils/const/widgets/byge-design-system/cards/expandable_card.dart';
import 'package:demo/utils/const/widgets/byge-design-system/checkbox/checkbox.dart';
import 'package:demo/utils/const/widgets/byge-design-system/input_fields/byge_input_field.dart';
import 'package:demo/utils/const/widgets/byge-design-system/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(mememberDropdownListProvider);
    final profileRepository = ref.watch(profileControllerProvider);
    final authRepository = ref.watch(authControllerProvider);
    ref.watch(chartDropdownListProvider);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Profil',
            style: TextStyle(fontSize: 24),
          ),
          vSpaceRegular,
          BygeExpandableCard(
            title: "Din konto",
            subtitle: 'Logg ut, bytt passord og samtykke',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Magnus.mo@hkraft.com',
                  style: TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 73, 73, 73)),
                ),
                vSpaceSmall,
                const Text(
                  'Samtykker du til at vi kan sende deg ja markedsføringsmateriell',
                  style: TextStyle(fontSize: 14),
                ),
                vSpaceRegular,
                BygePrimaryButton(
                  label: "Logg ut",
                  onPressed: () {
                    // Replace the current content with the "hello" content
                  },
                  labelColor: Colors.black,
                  color: Colors.white,
                  borderColor: const Color(0XFF404040),
                ),
                vSpaceSmall,
                BygePrimaryButton(
                  label: "Slett konto",
                  labelColor: Colors.black,
                  onPressed: () {
                    // Replace the current content with the "hello" content
                  },
                  color: Colors.white,
                  borderColor: const Color(0XFF404040),
                ),
                vSpaceSmall,
                BygePrimaryButton(
                  label: "Lagre endringer",
                  onPressed: () {
                    // Replace the current content with the "hello" content
                  },
                  color: const Color(0XFF404040),
                ),
              ],
            ),
          ),
          vSpaceRegular,
          BygeExpandableCard(
            title: "Ditt hjem",
            subtitle: 'Informasjon om din bolig, strømleverandør og forbruk',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Størrelse på boligen?',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                vSpaceSmall,
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.black)),
                  child: SizedBox(
                    height: 55,
                    child: Center(
                      child: DropdownButton(
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        hint: Text(
                          profileRepository.membersValue ??
                              "Størrelse på boligen",
                          style: labelLarge,
                        ),
                        underline: const SizedBox(),
                        isExpanded: true,
                        items: profileRepository.numberOfMembers
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (value) {
                          profileRepository.houseMemberValue(value);
                          ref
                              .read(mememberDropdownListProvider.notifier)
                              .state = value.toString();
                        },
                        onTap: () {},
                      ),
                    ),
                  ),
                ),
                vSpaceRegular,
                const Text(
                  'Personer i husstanden',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                vSpaceSmall,
                const SizedBox(
                  width: 100,
                  child: BygeInputField(
                    placeholder: 'Count',
                    placeholderColor: Color.fromARGB(255, 124, 123, 123),
                  ),
                ),
                vSpaceRegular,
                const Text(
                  'Hva har du i hjemmet?',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                vSpaceSmall,
                BygeCheckbox(
                  initialValue: true,
                  label: "Elbil",
                  onChanged: (value) {},
                ),
                vSpaceSmall,
                BygeCheckbox(
                  initialValue: true,
                  label: "Solceller",
                  onChanged: (value) {},
                ),
                vSpaceSmall,
                BygeCheckbox(
                  initialValue: true,
                  label: "Oppvaskmaskin",
                  onChanged: (value) {},
                ),
                vSpaceSmall,
                BygeCheckbox(
                  initialValue: true,
                  label: "Tørketrommel",
                  onChanged: (value) {},
                ),
                vSpaceSmall,
                BygeCheckbox(
                  initialValue: true,
                  label: "Vaskemaskin",
                  onChanged: (value) {},
                ),
                vSpaceSmall,
                BygeCheckbox(
                  initialValue: true,
                  label: "Varmepumpe",
                  onChanged: (value) {},
                ),
                vSpaceSmall,
                BygeCheckbox(
                  initialValue: true,
                  label: "HAN-sensor",
                  onChanged: (value) {},
                ),
                vSpaceRegular,
                BygePrimaryButton(
                  label: "Lagre endringer",
                  onPressed: () {
                    // Replace the current content with the "hello" content
                  },
                  color: const Color(0XFF404040),
                ),
              ],
            ),
          ),
          vSpaceRegular,
          BygeExpandableCard(
              title: "Strøm",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hvor bor du?',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  vSpaceSmall,
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.black)),
                    child: SizedBox(
                      height: 55,
                      child: Center(
                        child: DropdownButton(
                          icon: const Icon(Icons.keyboard_arrow_down_rounded),
                          hint: Text(
                            authRepository.dropdowmValue ?? "Velg strømsone",
                            style: labelLarge,
                          ),
                          underline: const SizedBox(),
                          isExpanded: true,
                          items: authRepository.dropdwonList
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (value) {
                            authRepository.changeDropDownValue(value);
                            ref.read(chartDropdownListProvider.notifier).state =
                                value.toString();
                          },
                          onTap: () {},
                        ),
                      ),
                    ),
                  ),
                  vSpaceRegular,
                  const Text(
                    'Strømleverandør',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  vSpaceSmall,
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.black)),
                    child: SizedBox(
                      height: 55,
                      child: Center(
                        child: DropdownButton(
                          icon: const Icon(Icons.keyboard_arrow_down_rounded),
                          hint: Text(
                            authRepository.dropdowmValue ??
                                "Din strømlevrandør",
                            style: labelLarge,
                          ),
                          underline: const SizedBox(),
                          isExpanded: true,
                          items: authRepository.dropdwonList
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (value) {
                            authRepository.changeDropDownValue(value);
                            ref.read(chartDropdownListProvider.notifier).state =
                                value.toString();
                          },
                          onTap: () {},
                        ),
                      ),
                    ),
                  ),
                  vSpaceRegular,
                  BygePrimaryButton(
                    label: "Lagre endringer",
                    onPressed: () {
                      // Replace the current content with the "hello" content
                    },
                    color: const Color(0XFF404040),
                  ),
                ],
              )),
          vSpaceRegular,
          BygeExpandableCard(
              title: "Pushvarslinger",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Motta varsel med strømpriser\nfor neste dag',
                        style: TextStyle(fontSize: 14),
                      ),
                      BygeToggleButton(
                        toggled: false,
                        toggleText: "",
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  vSpaceRegular,
                  BygePrimaryButton(
                    label: "Lagre endringer",
                    onPressed: () {
                      // Replace the current content with the "hello" content
                    },
                    color: const Color(0XFF404040),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
