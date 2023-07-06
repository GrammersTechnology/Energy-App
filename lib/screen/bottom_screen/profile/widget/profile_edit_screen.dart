import 'package:demo/const/space_helper.dart';
import 'package:demo/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../const/themes/colors.dart';
import '../../../../const/widgets/custom_button.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Controller = Provider.of<ProfileController>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Controller.fetchCSVData();
    });
    return Consumer<ProfileController>(builder: (context, controller, _) {
      return Scaffold(
        appBar: AppBar(),
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
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: DropdownButton(
                    iconEnabledColor: const Color.fromARGB(255, 27, 25, 25),
                    focusColor: const Color.fromARGB(255, 209, 204, 204),
                    borderRadius: BorderRadius.circular(10),
                    hint: Text(
                      userProfile?.powerCompany ??
                          controller.dropDownValue ??
                          " Select From List",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 36, 34, 34)),
                    ),
                    underline: const SizedBox(),
                    isExpanded: true,
                    items: controller.dropdwonList
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {
                      controller.changeDropDownValue(value);
                    },
                    onTap: () {},
                  ),
                ),
                vSpaceRegular,
                TextFormField(
                  controller: controller.nameController,
                  decoration: InputDecoration(
                    hintText: userProfile?.name ?? "Name",
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                ),
                vSpaceRegular,
                TextFormField(
                  controller: controller.zoneController,
                  decoration: InputDecoration(
                    hintText: userProfile?.pricezone ?? "Zone",
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                ),
                vSpaceRegular,
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: controller.yearlyCosumptionController,
                  decoration: InputDecoration(
                    hintText:
                        userProfile?.yearlyCosumption ?? "Yearly Consumption ",
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                ),
                vSpaceRegular,
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: controller.numberOfPepoleControler,
                  decoration: InputDecoration(
                    hintText: userProfile?.numberOfPepole ?? "Number Of Pepole",
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                ),
                vSpaceRegular,
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: controller.powerCoinsController,
                  decoration: InputDecoration(
                    hintText: userProfile?.powerCoins ?? "Power Coins",
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                ),
                vSpaceRegular,
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: controller.powerPointController,
                  decoration: InputDecoration(
                    hintText: userProfile?.powerPoint ?? "Power Point",
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
                        //         value: controller.allBool,
                        //         onChanged: (value) {
                        //           controller.allValueChange(value);
                        //         },
                        //       ),
                        //       hSpaceMedium
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          child: Row(
                            children: [
                              Text("Has El Car"),
                              Spacer(),
                              Switch(
                                value: controller.hasElCarBool,
                                onChanged: (value) {
                                  controller.hasElCarValueChange(value);
                                },
                              ),
                              hSpaceMedium
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Row(
                            children: [
                              Text("Want Push Warning2"),
                              Spacer(),
                              Switch(
                                value: controller.wantPushWarning2Bool,
                                onChanged: (value) {
                                  controller.wantPushWarning2ValueChange(value);
                                },
                              ),
                              hSpaceMedium
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Row(
                            children: [
                              Text("hasSensor"),
                              Spacer(),
                              Switch(
                                value: controller.hasSensorBool,
                                onChanged: (value) {
                                  controller.hasSensorValueChange(value);
                                },
                              ),
                              hSpaceMedium
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Row(
                            children: [
                              Text("wantPushWarning1"),
                              Spacer(),
                              Switch(
                                value: controller.wantPushWarning1Bool,
                                onChanged: (value) {
                                  controller.wantPushWarning1ValueChange(value);
                                },
                              ),
                              hSpaceMedium
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Row(
                            children: [
                              Text("hasEatPump"),
                              Spacer(),
                              Switch(
                                value: controller.hasEatPumpBool,
                                onChanged: (value) {
                                  controller.hasEatPumpValueChange(value);
                                },
                              ),
                              hSpaceMedium
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Row(
                            children: [
                              Text("hasSolarPanel"),
                              Spacer(),
                              Switch(
                                value: controller.hasSolarPanelBool,
                                onChanged: (value) {
                                  controller.hasSolarPanelValueChange(value);
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
                    controller.updateUserProfileDetails(context);
                  },
                  title: 'Update  Now',
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}