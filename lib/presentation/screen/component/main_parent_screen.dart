import 'package:chat_application/config/route/route_manager.dart';
import 'package:chat_application/generated/assets.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../config/theme/app_theme.dart';
import '../dashboard/dashboard_screen.dart';
import '../project/project_list_screen.dart';
import '../user/user_list_screen.dart';
import 'budge_icon.dart';
import 'custom_appbar.dart';
import 'drawer_screen.dart';

class MainParentScreen extends StatefulWidget {

  final Widget? child;

  const MainParentScreen({
    super.key,

    this.child,
  });

  @override
  State<MainParentScreen> createState() => _MainParentScreenState();
}

class _MainParentScreenState extends State<MainParentScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  var drawerItems = [
    DrawerItem(
        leading: const Icon(
          Icons.home_filled,
          size: 24,
        ),
        screen: const DashBoardScreen(),
        title: 'Dashboard',
        userCommonAction: true),
    DrawerItem(
        leading: const Icon(
          Icons.games,
          size: 24,
        ),
        screen: const ProjectListScreen(),
        title: 'Projects',
        userCommonAction: true),
    DrawerItem(
        leading: const Icon(
          Icons.people_alt,
          size: 24,
        ),
        screen: const UserListScreen(),
        title: 'User Manage',
        userCommonAction: true),
  ];

  @override
  Widget build(BuildContext context) {
    var item = drawerItems[_selectedIndex];
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        assertImage: Assets.imagesImpmLogo,
        title: item.screenTitle ?? item.title,
        isDrawerIcon: true,
        onLeadPress: () => _openDrawer(),
        actions: item.userCommonAction
            ? [
                BadgeIcon(
                    count: 34,
                    child: AppBarAction(
                        icon: Icons.notifications, onPress: () {})),
                const SizedBox(
                  width: 8,
                ),
                AppBarAction(
                  text: 'FF',
                  onPress: () {},
                  backgroundColor: AppColor.colorPurple,
                ),
                const SizedBox(
                  width: 16,
                ),
              ]
            : item.appbarActions,
      ),
      body: widget.child ?? item.screen,
      drawer: Drawer(
        backgroundColor: Colors.white,
        width: MediaQuery.of(context).size.width * 0.8,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: DrawerHeader(
                child: Image.asset(
                  Assets.imagesImpmLogo,
                  width: 200,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            ...drawerItems.mapIndexed(
              (index, e) => ListTile(
                leading: e.leading,
                title: Text(
                  e.title,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.normal),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Routes.dashboardScreen, arguments: index);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
