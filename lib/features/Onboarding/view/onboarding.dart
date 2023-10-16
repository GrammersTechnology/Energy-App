import 'package:demo/features/auth/controller/auth_controller.dart';
import 'package:demo/features/bottum_navigation_screen.dart';
import 'package:demo/features/chart/controller/chartcontroller.dart';
import 'package:demo/utils/const/space_helper.dart';
import 'package:demo/utils/const/widgets/byge-design-system/buttons/primary_button.dart';
import 'package:demo/utils/const/widgets/byge-design-system/theme/text_styles.dart';
import 'package:demo/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'byge.',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.only(bottom: 10, left: 20),
              child: Text(
                'Hei!',
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.w700),
              ),
            ),
            // vSpaceRegular,
            const Padding(
              padding: EdgeInsets.only(bottom: 10, left: 20),
              child: Text(
                'Så gøy at du vil teste Byge 🥳 vi skal\nhjelpe deg få oversikt over strømpriser\nog forbruk ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
            // vSpaceSmall,
            Padding(
              padding: const EdgeInsets.only(bottom: 50, left: 20, right: 20),
              child: BygePrimaryButton(
                label: "Ta meg videre",
                onPressed: () {
                  Routes.pushRemoveUntil(screen: const OnboardZone());
                },
                color: const Color(0XFF404040),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardZone extends ConsumerWidget {
  const OnboardZone({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepository = ref.watch(authControllerProvider);
    ref.watch(chartDropdownListProvider);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              vSpaceMedium,
              Center(
                child: Image.asset('assets/images/Zone-Map.png'),
              ),
              vSpaceXl,
              const Text(
                'Første må vi få vite hvilken strømsone du hører til, for å vise deg riktig strømpris.',
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w400, height: 1.3),
              ),
              vSpaceLarge,
              const Text(
                'Hvor i Norge bor du?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              vSpaceMedium,
              // const BygeExpandableCard(
              //     title: "Velg strømsone",
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text('No1'),
              //         Divider(),
              //         Text('NO1'),
              //         Divider(),
              //         Text('NO2'),
              //         Divider(),
              //         Text('NO3'),
              //         Divider(),
              //         Text('NO4'),
              //         Divider(),
              //         Text('NO5'),
              //       ],
              //     )),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.black)),
                child: SizedBox(
                  height: 80,
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
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
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
              vSpaceMedium,
              BygePrimaryButton(
                label: "Lagre og gå videre",
                onPressed: () {
                  Routes.pushRemoveUntil(screen: BottumNavigationScreen());
                },
                color: const Color(0XFF404040),
              ),
              vSpaceSmall,
            ],
          ),
        ),
      )),
    );
  }
}
