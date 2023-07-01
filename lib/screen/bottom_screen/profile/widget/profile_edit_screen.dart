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
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: DropdownButton(
                    iconEnabledColor: const Color.fromARGB(255, 27, 25, 25),
                    focusColor: const Color.fromARGB(255, 209, 204, 204),
                    borderRadius: BorderRadius.circular(10),
                    hint: Text(
                      controller.dropDownValue ?? " Select From List",
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
                    hintText: userProfile!.name.toString().isEmpty
                        ? "Name"
                        : userProfile?.name,
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
                  controller: controller.yearlyCosumptionController,
                  decoration: const InputDecoration(
                    hintText: "Yearly Consumption ",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                ),
                vSpaceRegular,
                TextFormField(
                  controller: controller.numberOfPepoleControler,
                  decoration: const InputDecoration(
                    hintText: "Number Of Pepole",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                ),
                vSpaceRegular,
                TextFormField(
                  controller: controller.powerCoinsController,
                  decoration: const InputDecoration(
                    hintText: "Power Coins",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                ),
                vSpaceRegular,
                TextFormField(
                  controller: controller.powerPointController,
                  decoration: const InputDecoration(
                    hintText: "Power Point",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          Checkbox(
                            value: controller.hasElCarBool,
                            onChanged: (value) {
                              controller.hasElCarValueChange(value);
                            },
                          ),
                          const Text("Has El Car")
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        children: [
                          Checkbox(
                            value: controller.wantPushWarning2Bool,
                            onChanged: (value) {
                              controller.wantPushWarning2ValueChange(value);
                            },
                          ),
                          const Text("Want Push Warning2")
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          Checkbox(
                            value: controller.hasSensorBool,
                            onChanged: (value) {
                              controller.hasSensorValueChange(value);
                            },
                          ),
                          const Text("hasSensor")
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        children: [
                          Checkbox(
                            value: controller.wantPushWarning1Bool,
                            onChanged: (value) {
                              controller.wantPushWarning1ValueChange(value);
                            },
                          ),
                          const Text("wantPushWarning1")
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          Checkbox(
                            value: controller.hasEatPumpBool,
                            onChanged: (value) {
                              controller.hasEatPumpValueChange(value);
                            },
                          ),
                          const Text("hasEatPump")
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        children: [
                          Checkbox(
                            value: controller.hasSolarPanelBool,
                            onChanged: (value) {
                              controller.hasSolarPanelValueChange(value);
                            },
                          ),
                          const Text("hasSolarPanel")
                        ],
                      ),
                    ),
                  ],
                ),
                LoginButtonWidget(
                  onTap: () {
                    controller.updateUserProfileDetails(
                        controller.hasSensorBool,
                        controller.hasElCarBool,
                        controller.hasEatPumpBool,
                        controller.hasSolarPanelBool,
                        controller.wantPushWarning1Bool,
                        controller.wantPushWarning2Bool,
                        context);
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
