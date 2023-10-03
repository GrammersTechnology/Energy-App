import 'package:demo/const/space_helper.dart';
import 'package:demo/riverpod/profile/controller/profile_controller.dart';
import 'package:demo/riverpod/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../const/themes/colors.dart';
import '../../../const/widgets/custom_button.dart';
import '../../../model/model.dart';

class ProfileEditScreen extends ConsumerWidget {
  ProfileEditScreen({super.key, required this.data});
  ProfileModel data;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    final profileRepository = ref.watch(profileControllerProvider);
    //   profileRepository.fetchCSVData();
    // });
    ref.watch(profileEditDropdownListProvider);
    ref.watch(profileEditZoneProvider);
    ref.watch(hasElCarStateProvider);
    ref.watch(wantPushWarning2StateProvider);
    ref.watch(hasSensorStateProvider);
    ref.watch(wantPushWarning1StateProvider);
    ref.watch(hasEatPumpStateProvider);
    ref.watch(hasSolarPanelStateProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                width: 130,
                height: 130,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.dashedLineColor,
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.network(
                    'https://static.vecteezy.com/system/resources/previews/019/896/008/original/male-user-avatar-icon-in-flat-design-style-person-signs-illustration-png.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ref.watch(profileEditProvider).when(
                data: (dropdwonData) {
                  return Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: DropdownButton(
                      iconEnabledColor: const Color.fromARGB(255, 27, 25, 25),
                      focusColor: const Color.fromARGB(255, 209, 204, 204),
                      borderRadius: BorderRadius.circular(10),
                      hint: Text(
                        profileRepository.dropDownValue ?? data.powerCompany,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 36, 34, 34),
                        ),
                      ),
                      underline: const SizedBox(),
                      isExpanded: true,
                      items: dropdwonData
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) {
                        profileRepository.changeDropDownValue(value);
                        ref
                            .read(profileEditDropdownListProvider.notifier)
                            .state = value.toString();
                      },
                      onTap: () {},
                    ),
                  );
                },
                error: (error, stackTrace) {
                  return Text("data");
                },
                loading: () {
                  return CircularProgressIndicator();
                },
              ),
              vSpaceRegular,
              TextFormField(
                controller: profileRepository.nameController,
                decoration: InputDecoration(
                  label: const Text("Name"),
                  hintText: data.name,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
              ),
              vSpaceRegular,
              Container(
                padding: const EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    border: Border.all(color: Colors.grey)),
                child: DropdownButton(
                  hint: Text(profileRepository.zoneDropdowmValue ??
                      " Select From List"),
                  underline: const SizedBox(),
                  isExpanded: true,
                  items: profileRepository.zoneDropdwonList
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    profileRepository.changeZoneDropDownValue(value);
                    ref.read(profileEditZoneProvider.notifier).state =
                        value.toString();
                  },
                  onTap: () {},
                ),
              ),
              vSpaceRegular,
              TextFormField(
                keyboardType: TextInputType.number,
                controller: profileRepository.yearlyCosumptionController,
                decoration: InputDecoration(
                  label: const Text("Yearly Consumption"),
                  hintText: data.yearlyCosumption,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
              ),
              vSpaceRegular,
              TextFormField(
                keyboardType: TextInputType.number,
                controller: profileRepository.numberOfPepoleControler,
                decoration: InputDecoration(
                  label: const Text("Number Of Pepole"),
                  hintText: data.numberOfPepole,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
              ),
              vSpaceRegular,
              TextFormField(
                keyboardType: TextInputType.number,
                controller: profileRepository.powerCoinsController,
                decoration: InputDecoration(
                  label: const Text("Power Coins"),
                  hintText: data.powerCoins,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
              ),
              vSpaceRegular,
              TextFormField(
                keyboardType: TextInputType.number,
                controller: profileRepository.powerPointController,
                decoration: InputDecoration(
                  label: const Text("Power Point"),
                  hintText: data.powerPoint,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        child: Row(
                          children: [
                            const Text("Has El Car"),
                            const Spacer(),
                            Switch(
                              value: profileRepository.hasElCarBool,
                              onChanged: (value) {
                                profileRepository.hasElCarValueChange(value);
                                ref.read(hasElCarStateProvider.notifier).state =
                                    value;
                              },
                            ),
                            hSpaceMedium
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Row(
                          children: [
                            const Text("Want Push Warning2"),
                            const Spacer(),
                            Switch(
                              value: profileRepository.wantPushWarning2Bool,
                              onChanged: (value) {
                                profileRepository
                                    .wantPushWarning2ValueChange(value);
                                ref
                                    .read(
                                        wantPushWarning2StateProvider.notifier)
                                    .state = value;
                              },
                            ),
                            hSpaceMedium
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Row(
                          children: [
                            const Text("hasSensor"),
                            const Spacer(),
                            Switch(
                              value: profileRepository.hasSensorBool,
                              onChanged: (value) {
                                profileRepository.hasSensorValueChange(value);
                                ref
                                    .read(hasSensorStateProvider.notifier)
                                    .state = value;
                              },
                            ),
                            hSpaceMedium
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Row(
                          children: [
                            const Text("wantPushWarning1"),
                            const Spacer(),
                            Switch(
                              value: profileRepository.wantPushWarning1Bool,
                              onChanged: (value) {
                                profileRepository
                                    .wantPushWarning1ValueChange(value);
                                ref
                                    .read(
                                        wantPushWarning1StateProvider.notifier)
                                    .state = value;
                              },
                            ),
                            hSpaceMedium
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Row(
                          children: [
                            const Text("hasEatPump"),
                            const Spacer(),
                            Switch(
                              value: profileRepository.hasEatPumpBool,
                              onChanged: (value) {
                                profileRepository.hasEatPumpValueChange(value);
                                ref
                                    .read(hasEatPumpStateProvider.notifier)
                                    .state = value;
                              },
                            ),
                            hSpaceMedium
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Row(
                          children: [
                            const Text("hasSolarPanel"),
                            const Spacer(),
                            Switch(
                              value: profileRepository.hasSolarPanelBool,
                              onChanged: (value) {
                                profileRepository
                                    .hasSolarPanelValueChange(value);
                                ref
                                    .read(hasSolarPanelStateProvider.notifier)
                                    .state = value;
                              },
                            ),
                            hSpaceMedium
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              LoginButtonWidget(
                onTap: () {
                  profileRepository.updateUserProfileDetails(context);
                },
                title: 'Update  Now',
              )
            ],
          ),
        ),
      ),
    );
  }
}
