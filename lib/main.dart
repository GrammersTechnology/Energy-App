import 'package:demo/utils/const/themes/colors.dart';
import 'package:demo/features/navbar_widget.dart';
import 'package:demo/utils/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'utils/controller/local_notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().initNotification();
  // NotificationService().showNotification();
  // NotificationService().morningNotification();
  // NotificationService().afterNoonNotification();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Routes.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: AppColors.primaryColor),
      home: const Scaffold(
        body: NavBarWidget(
            // child: SingleChildScrollView(
            //   child: Column(children: [
            //     // ButtonExamples(),
            //     BygePrimaryButton(label: "eee", onPressed: () {}),
            //     // BygeSecondaryButton(
            //     //   label: "label",
            //     //   onPressed: () {},
            //     // ),
            //     // BygeTertiaryButton(
            //     //   label: "label",
            //     //   onPressed: () {},
            //     // ),
            // BygeToggleButton(
            //   toggled: true,
            //   toggleText: "toggleText",
            //   onChanged: (value) {},
            // ),
            //     // ToggleExamples()
            //     BygeNavCardExample(),
            //     BygeNavCard(
            //       title: "title",
            //       child: Text("data"),
            //       destination: Text('f'),
            //       iconData: Icons.abc,
            //       iconSize: 20,
            //     ),
            //     ExpandableCardExamples(),
            //     BygeExpandableCard(title: "title", child: Text("data")),
            //     CheckboxExamples(),
            // BygeCheckbox(
            //   initialValue: true,
            //   label: "label",
            //   onChanged: (value) {},
            // ),
            //     // BygeDropdown(dropdownEntry: [], dropdownHint: dropdownHint, onSelected: onSelected)
            //     ErrorExamples(),
            //     // BygeTabbedWidgets(widgets: [], tabNames: [])
            //   ]),
            // ),
            ),
      ),
    );
  }
}
