import 'package:demo/riverpod/Hva%20Koster/view/hva_koster_screen.dart';
import 'package:demo/riverpod/Saving%20Tips/view/tips_screen.dart';
import 'package:demo/riverpod/home/home_screen.dart';
import 'package:demo/riverpod/profile/view/profil_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BottumNavigationScreen extends StatelessWidget {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  BottumNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PersistentTabView(
      context,
      controller: _controller,
      screens: [
        HomeScreen(),
        TipsScreen(),
        // ChartScreen(),

        Container(),
        HvaKosterScreen(),
        ProfileScreen()
      ],
      items: [
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.graph_circle),
          title: ("Home"),
          activeColorPrimary: CupertinoColors.white,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.square_list),
          title: ("Sparetips"),
          activeColorPrimary: CupertinoColors.white,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.map),
          title: ("Status"),
          activeColorPrimary: CupertinoColors.white,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.money_dollar_circle),
          title: ("HVA Koster"),
          activeColorPrimary: CupertinoColors.white,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.profile_circled),
          title: ("Profile"),
          activeColorPrimary: CupertinoColors.white,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ],
      confineInSafeArea: true,
      backgroundColor: const Color.fromARGB(255, 14, 78, 131),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: const NavBarDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        colorBehindNavBar: Colors.blue,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1,
    ));
  }
}
