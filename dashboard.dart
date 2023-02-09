import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:social_media/res/color.dart';
import 'package:social_media/view/dashboard/profile_Screen/profile_Screen.dart';

import 'user/user_list_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<PersistentBottomNavBarItem> _navBarItem() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.home, color: Colors.tealAccent),
          activeColorPrimary: Colors.transparent),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.message, color: Colors.tealAccent),
          activeColorPrimary: Colors.transparent),
      PersistentBottomNavBarItem(
          icon: const Icon(
            Icons.add,
            color: AppColors.alertColor,
          ),
          activeColorPrimary: Colors.transparent),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.perm_contact_cal_outlined,
              color: Colors.tealAccent),
          inactiveIcon:
              const Icon(Icons.perm_contact_cal, color: Colors.tealAccent),
          activeColorPrimary: Colors.transparent),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.person_outline_outlined,
              color: Colors.tealAccent),
          activeColorPrimary: Colors.transparent),
    ];
  }

  List<Widget> _buildScreen() {
    return [
      const SafeArea(child: Text('Home')),
      const SafeArea(child: Text('Chat')),
      const SafeArea(child: Text('Add')),
      const UserListScreen(),
      const ProfileScreen()
    ];
  }

  final controler = PersistentTabController(initialIndex: 2);
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      backgroundColor: AppColors.whiteColor,
      screens: _buildScreen(),
      items: _navBarItem(),
      controller: controler,
      decoration: NavBarDecoration(borderRadius: BorderRadius.circular(1)),
      // navBarStyle: NavBarStyle.style15,
    );
  }
}
