import 'package:chat_application/data/local/preference_repository.dart';
import 'package:chat_application/presentation/screen/component/show_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../config/route/route_manager.dart';
import '../../../config/theme/app_theme.dart';
import '../../../injection_conatainer.dart' as di;
import 'component.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Widget getDrawerTile(String name, IconData iconData, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          iconData,
          color: Colors.black,
        ),
        title: Text(
          name,
          style: const TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.normal),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Drawer(
      backgroundColor: Colors.white,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            alignment: Alignment.bottomLeft,
            color: colorPrimary300,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    clipBehavior: Clip.hardEdge,
                    child: Image(
                      image: const AssetImage('assets/images/group_icon.png'),
                      fit: BoxFit.fill,
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.height * 0.1,
                    ),
                  ),
                  Text(
                    "name",
                    style: theme.textTheme.titleLarge,
                  ),
                  Text(
                    "(role)",
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          getDrawerTile("Dashboard".tr(), Icons.dashboard, () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, Routes.dashboardScreen);
          }),
          getDrawerTile("Projects", Icons.palette_rounded, () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, Routes.projectListScreen);
          }),
          getDrawerTile("Groups", Icons.group_work_outlined, () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, Routes.groupListScreen);
          }),
          getDrawerTile("Members", Icons.groups, () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, Routes.userListScreen);
          }),
          getDrawerTile("Profile", Icons.person, () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, Routes.personalInfoScreen);
          }),
          getDrawerTile("Forgot Password", Icons.password, () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, Routes.forgotPasswordRoute);
          }),
          getDrawerTile("About", Icons.info, () {}),
          // Expanded(child: Container()),
          SizedBox(
            width: double.infinity,
            child: defaultTextButton(
              style: const TextStyle(
                  fontWeight: FontWeight.w400, color: colorPrimary),
              function: () async {
                showAlertDialog(
                    context: context,
                    title: "Log out",
                    message: "Are you sure you want to logout?",
                    onCancel: () {
                      Navigator.pop(context);
                    },
                    onSubmit: () {
                      di.di<PreferenceRepository>().clearPreference();
                      Navigator.of(context).pop();
                      Navigator.pushNamedAndRemoveUntil(
                          context, Routes.signInRoute, (route) => false);
                    });
              },
              text: 'Log out',
            ),
          )
        ],
      ),
    );
  }
}
