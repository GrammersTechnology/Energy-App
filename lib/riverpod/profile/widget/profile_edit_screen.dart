import 'package:demo/const/space_helper.dart';
import 'package:demo/riverpod/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';

import '../../../const/themes/colors.dart';
import '../../../const/widgets/custom_button.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ProfileController().fetchCSVData();
    });

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
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: DropdownButton(
                  iconEnabledColor: const Color.fromARGB(255, 27, 25, 25),
                  focusColor: const Color.fromARGB(255, 209, 204, 204),
                  borderRadius: BorderRadius.circular(10),
                  hint: Text(
                    (userProfile?.powerCompany.isNotEmpty == true)
                        ? userProfile!.powerCompany
                        : (ProfileController().dropDownValue?.isNotEmpty ==
                                true)
                            ? ProfileController().dropDownValue!
                            : "Select From List",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 36, 34, 34),
                    ),
                  ),
                  underline: const SizedBox(),
                  isExpanded: true,
                  items: ProfileController()
                      .dropdwonList
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    ProfileController().changeDropDownValue(value);
                  },
                  onTap: () {},
                ),
              ),
              vSpaceRegular,
              TextFormField(
                controller: ProfileController().nameController,
                decoration: InputDecoration(
                  label: const Text("Name"),
                  hintText: (userProfile?.name.isNotEmpty == true)
                      ? userProfile?.name
                      : "Name",
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
                  hint: Text(ProfileController().zoneDropdowmValue ??
                      " Select From List"),
                  underline: const SizedBox(),
                  isExpanded: true,
                  items: ProfileController()
                      .zoneDropdwonList
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    ProfileController().changeZoneDropDownValue(value);
                  },
                  onTap: () {},
                ),
              ),
              // vSpaceRegular,
              // TextFormField(
              //   keyboardType: TextInputType.number,
              //   controller: ProfileController().zoneController,
              //   decoration: InputDecoration(
              //     label: const Text("Zone"),
              //     hintText: (userProfile?.pricezone.isNotEmpty == true)
              //         ? userProfile?.pricezone
              //         : "Zone",
              //     border: const OutlineInputBorder(
              //       borderRadius: BorderRadius.all(Radius.circular(30)),
              //     ),
              //   ),
              // ),
              vSpaceRegular,
              TextFormField(
                keyboardType: TextInputType.number,
                controller: ProfileController().yearlyCosumptionController,
                decoration: InputDecoration(
                  label: const Text("Yearly Consumption"),
                  hintText: (userProfile?.yearlyCosumption != "0")
                      ? userProfile?.yearlyCosumption
                      : "Yearly Consumption ",
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
              ),
              vSpaceRegular,
              TextFormField(
                keyboardType: TextInputType.number,
                controller: ProfileController().numberOfPepoleControler,
                decoration: InputDecoration(
                  label: const Text("Number Of Pepole"),
                  hintText: (userProfile?.numberOfPepole != "0")
                      ? userProfile?.numberOfPepole
                      : "Number Of Pepole",
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
              ),
              vSpaceRegular,
              TextFormField(
                keyboardType: TextInputType.number,
                controller: ProfileController().powerCoinsController,
                decoration: InputDecoration(
                  label: const Text("Power Coins"),
                  hintText: (userProfile?.powerCoins != "0")
                      ? userProfile?.powerCoins
                      : "Power Coins",
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
              ),
              vSpaceRegular,
              TextFormField(
                keyboardType: TextInputType.number,
                controller: ProfileController().powerPointController,
                decoration: InputDecoration(
                  label: const Text("Power Point"),
                  hintText: (userProfile?.powerPoint != "0")
                      ? userProfile?.powerPoint
                      : "Power Point",
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
                      // SizedBox(
                      //   child: Row(
                      //     children: [
                      //       Text("All"),
                      //       Spacer(),
                      //       Switch(
                      //         value: ProfileController().allBool,
                      //         onChanged: (value) {
                      //           ProfileController().allValueChange(value);
                      //         },
                      //       ),
                      //       hSpaceMedium
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        child: Row(
                          children: [
                            const Text("Has El Car"),
                            const Spacer(),
                            Switch(
                              value: ProfileController().hasElCarBool,
                              onChanged: (value) {
                                ProfileController().hasElCarValueChange(value);
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
                              value: ProfileController().wantPushWarning2Bool,
                              onChanged: (value) {
                                ProfileController()
                                    .wantPushWarning2ValueChange(value);
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
                              value: ProfileController().hasSensorBool,
                              onChanged: (value) {
                                ProfileController().hasSensorValueChange(value);
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
                              value: ProfileController().wantPushWarning1Bool,
                              onChanged: (value) {
                                ProfileController()
                                    .wantPushWarning1ValueChange(value);
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
                              value: ProfileController().hasEatPumpBool,
                              onChanged: (value) {
                                ProfileController()
                                    .hasEatPumpValueChange(value);
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
                              value: ProfileController().hasSolarPanelBool,
                              onChanged: (value) {
                                ProfileController()
                                    .hasSolarPanelValueChange(value);
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
                  ProfileController().updateUserProfileDetails(context);
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
