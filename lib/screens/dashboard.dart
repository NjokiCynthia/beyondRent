import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:x_rent/screens/dashboard/home.dart';
import 'package:x_rent/screens/dashboard/profile.dart';
import 'package:x_rent/screens/dashboard/tenants/list_tenants.dart';
import 'package:x_rent/screens/dashboard/units/list_units.dart';
import 'package:x_rent/utilities/constants.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    bottomNavigationController = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      const Home(),
      const Units(),
      const ListTenants(),
      const Settings(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Property"),
        activeColorPrimary: mintyGreen,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.apartment),
        title: ("Units"),
        activeColorPrimary: mintyGreen,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.people_outline_outlined),
        title: ("Statements"),
        activeColorPrimary: mintyGreen,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings),
        title: ("Settings"),
        activeColorPrimary: mintyGreen,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: bottomNavigationController,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineToSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: false,
        hideNavigationBarWhenKeyboardAppears: true,
        decoration: const NavBarDecoration(colorBehindNavBar: Colors.white),
        //popAllScreensOnTapOfSelectedTab: true,
        //popBehaviorOnSelectedNavBarItemPress: PopActionScreensType.all,
        animationSettings: const NavBarAnimationSettings(
          navBarItemAnimation: ItemAnimationSettings(
            // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimationSettings(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            duration: Duration(milliseconds: 200),
            screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
          ),
        ),
        navBarStyle: NavBarStyle.style6,
        onItemSelected: (value) {
          propertyUnitsList;
        },
      ),
    );
  }
}
