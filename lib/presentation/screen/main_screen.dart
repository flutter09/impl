import 'package:chat_application/config/theme/app_theme.dart';
import 'package:chat_application/presentation/screen/component/drawer_screen.dart';
import 'package:chat_application/presentation/screen/project/project_list_screen.dart';
import 'package:chat_application/presentation/screen/user/user_list_screen.dart';
import 'package:flutter/material.dart';

import 'component/budge_icon.dart';
import 'component/custom_appbar.dart';
import 'dashboard/dashboard_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return DrawerScreen(drawerItems: [
      DrawerItem(
          leading: const Icon(
            Icons.home_filled,
            size: 24,
          ),
          screen: const DashBoardScreen(),
          title: 'Dashboard',
          userCommonAction: true),
      DrawerItem(
          leading:const Icon(
            Icons.games,
            size: 24,
          ),
          screen: const ProjectListScreen(),
          title: 'Projects',
          userCommonAction: true),
      DrawerItem(
          leading:const Icon(
            Icons.people_alt,
            size: 24,
          ),
          screen: const UserListScreen(),
          title: 'User Manage',
          userCommonAction: true),
    ], appbarActions: [
      BadgeIcon(
          count: 34,
          child: AppBarAction(icon: Icons.notifications, onPress: () {})),
      const SizedBox(
        width: 8,
      ),
      AppBarAction(text: 'FF', onPress: () {}, backgroundColor: AppColor.colorPurple,),
      const SizedBox(
        width: 16,
      ),
    ]);
  }
}
