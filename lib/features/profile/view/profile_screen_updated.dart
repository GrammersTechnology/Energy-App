import 'dart:developer';

import 'package:demo/features/auth/controller/auth_controller.dart';
import 'package:demo/features/navbar_widget.dart';
import 'package:demo/features/profile/controller/profile_controller.dart';
import 'package:demo/utils/const/space_helper.dart';
import 'package:demo/utils/const/widgets/byge-design-system/buttons/primary_button.dart';
import 'package:demo/utils/const/widgets/byge-design-system/buttons/toggle_button.dart';
import 'package:demo/utils/const/widgets/byge-design-system/cards/expandable_card.dart';
import 'package:demo/utils/const/widgets/byge-design-system/checkbox/checkbox.dart';
import 'package:demo/utils/const/widgets/byge-design-system/input_fields/byge_input_field.dart';
import 'package:demo/utils/const/widgets/byge-design-system/theme/text_styles.dart';
import 'package:demo/utils/controller/provider.dart';
import 'package:demo/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/profile_model.dart';

class ProfilePage extends ConsumerWidget {
  ProfilePage({super.key});
  List<String> dropdwonList = [];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("profile screen");
    final controller = ref.watch(authControllerProvider);

    ref.watch(mememberDropdownListProvider);
    final profileRepository = ref.watch(profileControllerProvider);
    ref.watch(profileCompanyDropdownListProvider);
    ref.watch(profileEditZoneProvider);
    ref.watch(hasElCarStateProvider);
    ref.watch(hasSolarPanelStateProvider);
    ref.watch(oppvaskmaskinStateProvider);
    ref.watch(torketrommelStateProvider);
    ref.watch(vaskemaskinStateProvider);
    ref.watch(hasHeatPumpStateProvider);
    ref.watch(hasSensorStateProvider);
    ref.watch(wantPushWarning1StateProvider);
    ref.watch(stateUpdateProvider);

    return SafeArea(
        child: ref.watch(profileProvider).when(
      data: (data) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Profil',
              style: TextStyle(fontSize: 24),
            ),
            vSpaceRegular,
            LogoutWidget(
                profileRepository: profileRepository, controller: controller),
            vSpaceRegular,
            FamilyMemberWidget(
                userProfile: data,
                profileRepository: profileRepository,
                controller: controller),
            vSpaceRegular,
            ZoneWidget(
                userProfile: data,
                profileRepository: profileRepository,
                controller: controller),
            vSpaceRegular,
            pushNavigationWidget(
                profileRepository: profileRepository, controller: controller),
          ],
        );
      },
      error: (error, stackTrace) {
        return Text("data");
      },
      loading: () {
        return Center(child: CircularProgressIndicator());
      },
    ));
  }
}

class pushNavigationWidget extends ConsumerWidget {
  pushNavigationWidget(
      {super.key,
      required this.profileRepository,
      required this.controller,
      this.userProfile});

  final ProfileController profileRepository;
  final AuthController controller;
  ProfileModel? userProfile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BygeExpandableCard(
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
                  toggled: userProfile?.wantPushWarning ??
                      profileRepository.wantPushWarning1Bool,
                  toggleText: "",
                  onChanged: (value) {
                    profileRepository.wantPushWarning1ValueChange(value);
                    ref.read(wantPushWarning1StateProvider.notifier).state =
                        value ?? false;
                  },
                ),
              ],
            ),
            vSpaceRegular,
            BygePrimaryButton(
              label: "Lagre endringer",
              onPressed: () {
                profileRepository.pushVars();
                // Replace the current content with the "hello" content
              },
              color: const Color(0XFF404040),
            ),
          ],
        ));
  }
}

class LogoutWidget extends ConsumerWidget {
  const LogoutWidget({
    super.key,
    required this.profileRepository,
    required this.controller,
  });

  final ProfileController profileRepository;
  final AuthController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BygeExpandableCard(
      title: "Din konto",
      subtitle: 'Logg ut, bytt passord og samtykke',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            profileRepository.fb.currentUser?.email ?? "",
            style:
                TextStyle(fontSize: 14, color: Color.fromARGB(255, 73, 73, 73)),
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
              AuthController().clearLocalData();
              ref.read(stateUpdateProvider.notifier).state =
                  controller.showContent;
              ref.read(stateUpdateProvider.notifier).state =
                  controller.profileverify;
              Routes.pushreplace(screen: NavBarWidget());
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
              borderColor: const Color(0XFF404040)),
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
    );
  }
}

class FamilyMemberWidget extends ConsumerWidget {
  FamilyMemberWidget(
      {super.key,
      required this.profileRepository,
      required this.controller,
      this.userProfile});
  ProfileModel? userProfile;

  final ProfileController profileRepository;
  final AuthController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BygeExpandableCard(
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
                    profileRepository.membersDropdownValue ??
                        userProfile?.storreise ??
                        "Størrelse på boligen",
                    style: labelLarge,
                  ),
                  underline: const SizedBox(),
                  isExpanded: true,
                  items: profileRepository.numberOfMembers
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    profileRepository.houseMemberDropdownValue(value);
                    ref.read(mememberDropdownListProvider.notifier).state =
                        value.toString();
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
          SizedBox(
            width: 100,
            child: BygeInputField(
              controller: profileRepository.countController,
              placeholder: userProfile?.count.trim() ?? 'Count',
              placeholderColor: const Color.fromARGB(255, 124, 123, 123),
            ),
          ),
          vSpaceRegular,
          const Text(
            'Hva har du i hjemmet?',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          vSpaceSmall,
          BygeCheckbox(
            initialValue: profileRepository.hasElCarBool,
            label: "Elbil",
            onChanged: (value) {
              profileRepository.hasElCarValueChange(value);
              ref.read(hasElCarStateProvider.notifier).state = value ?? true;
            },
          ),
          vSpaceSmall,
          BygeCheckbox(
            initialValue: profileRepository.hasSolarPanelBool,
            label: "Solceller",
            onChanged: (value) {
              profileRepository.hasSolarPanelValueChange(value);
              ref.read(hasSolarPanelStateProvider.notifier).state =
                  value ?? false;
            },
          ),
          vSpaceSmall,
          BygeCheckbox(
            initialValue: profileRepository.oppvaskmaskin,
            label: "Oppvaskmaskin",
            onChanged: (value) {
              profileRepository.oppvaskmakinChange(value);
              ref.read(oppvaskmaskinStateProvider.notifier).state =
                  value ?? false;
            },
          ),
          vSpaceSmall,
          BygeCheckbox(
            initialValue: profileRepository.torketrommel,
            label: "Tørketrommel",
            onChanged: (value) {
              profileRepository.torketommelChange(value);
              ref.read(torketrommelStateProvider.notifier).state =
                  value ?? false;
            },
          ),
          vSpaceSmall,
          BygeCheckbox(
            initialValue: profileRepository.vaskemaskin,
            label: "Vaskemaskin",
            onChanged: (value) {
              print(value);
              profileRepository.vaskemaskinChange(value);
              ref.read(vaskemaskinStateProvider.notifier).state =
                  value ?? false;
            },
          ),
          vSpaceSmall,
          BygeCheckbox(
            initialValue: profileRepository.hasHeatPumpBool,
            label: "Varmepumpe",
            onChanged: (value) {
              profileRepository.hasHeatPumpValueChange(value);
              ref.read(hasHeatPumpStateProvider.notifier).state =
                  value ?? false;
            },
          ),
          vSpaceSmall,
          BygeCheckbox(
            initialValue: profileRepository.hasSensorBool,
            label: "HAN-sensor",
            onChanged: (value) {
              profileRepository.hasSensorValueChange(value);
              ref.read(hasSensorStateProvider.notifier).state = value ?? false;
            },
          ),
          vSpaceRegular,
          BygePrimaryButton(
            label: "Lagre endringer",
            onPressed: () {
              profileRepository.updateUserProfiledittHjemSaveDetails(
                  userProfile, context);
              // Replace the current content with the "hello" content
            },
            color: const Color(0XFF404040),
          ),
        ],
      ),
    );
  }
}

class ZoneWidget extends ConsumerWidget {
  ZoneWidget(
      {super.key,
      required this.profileRepository,
      required this.controller,
      this.userProfile});

  final ProfileController profileRepository;
  final AuthController controller;
  ProfileModel? userProfile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> dropdwonList = [];
    return BygeExpandableCard(
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
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.black)),
              child: SizedBox(
                height: 55,
                child: Center(
                  child: DropdownButton(
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    hint: Text(
                      profileRepository.zoneDropdowmValue ??
                          userProfile?.pricezone ??
                          "Velg strømsone",
                      style: labelLarge,
                    ),
                    underline: const SizedBox(),
                    items: profileRepository.zoneDropdwonList
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {
                      profileRepository.changeZoneDropDownValue(value);
                      ref.read(profileEditZoneProvider.notifier).state =
                          value.toString();
                    },
                    onTap: () {
                      profileRepository.saveStrom();
                    },
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
            FutureBuilder(
                future: profileRepository.fetchCSVData(),
                builder: (context, snaphot) {
                  if (snaphot.hasData) {
                    dropdwonList = snaphot.data ?? [];
                  }
                  return Container(
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
                            profileRepository.dropDownValue ??
                                ProfileController.userProfile?.powerCompany ??
                                "Din strømlevrandør",
                            style: labelLarge,
                          ),
                          underline: const SizedBox(),
                          isExpanded: true,
                          items: dropdwonList
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (value) {
                            profileRepository.changeDropDownValue(value);
                            ref
                                .read(
                                    profileCompanyDropdownListProvider.notifier)
                                .state = value.toString();
                          },
                          onTap: () {},
                        ),
                      ),
                    ),
                  );
                }),
            vSpaceRegular,
            BygePrimaryButton(
              label: "Lagre endringer",
              onPressed: () {
                profileRepository.saveStrom();
                // Replace the current content with the "hello" content
              },
              color: const Color(0XFF404040),
            ),
          ],
        ));
  }
}
