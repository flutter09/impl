import 'package:chat_application/generated/assets.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'custom_appbar.dart';

class DrawerItem {
  final Widget leading;
  final String title;
  final Widget screen;
  final String? screenTitle;
  final List<Widget>? appbarActions;
  final bool userCommonAction;

  DrawerItem(
      {required this.leading,
      required this.title,
      required this.screen,
      this.screenTitle,
      this.appbarActions,
      this.userCommonAction = false});
}

class DrawerScreen extends StatefulWidget {
  final Widget? drawerHeader;
  final List<DrawerItem> drawerItems;
  final List<Widget> appbarActions;

  const DrawerScreen({
    super.key,
    required this.drawerItems,
    this.drawerHeader,
    required this.appbarActions,
  });

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
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

  @override
  Widget build(BuildContext context) {
    var item = widget.drawerItems[_selectedIndex];
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        assertImage: Assets.imagesImpmLogo,
        title: item.screenTitle ?? item.title,
        isDrawerIcon: true,
        onLeadPress: () => _openDrawer(),
        actions:
            item.userCommonAction ? widget.appbarActions : item.appbarActions,
      ),
      body: item.screen,
      drawer: Drawer(
        backgroundColor: Colors.white,
        width: MediaQuery.of(context).size.width * 0.8,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            widget.drawerHeader ??
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
            ...widget.drawerItems.mapIndexed(
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
                  _onItemTapped(index);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
