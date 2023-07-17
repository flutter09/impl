import 'package:chat_application/presentation/screen/component/show_dialog.dart';
import 'package:flutter/material.dart';

import '../../../config/route/route_manager.dart';
import '../../../config/theme/app_theme.dart';
import 'component.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Widget getDrawerTile(String name, IconData iconData) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04),
      child: ListTile(
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
            padding: const EdgeInsets.symmetric(horizontal: 5 , vertical: 10),
            alignment: Alignment.bottomLeft,
            color: Colors.white,
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
                const SizedBox(height: 10,),
                const Divider(
                  height: 3,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          getDrawerTile("Total order", Icons.library_books),
          getDrawerTile("Your details", Icons.person),
          getDrawerTile("Forgot password", Icons.password),
          getDrawerTile("Add Food", Icons.fastfood_sharp),
          getDrawerTile("Add User", Icons.person_add),
          getDrawerTile("Add Table", Icons.table_restaurant_sharp),
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
