import 'package:chat_application/config/route/route_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../config/theme/app_theme.dart';
import '../component/custom_appbar.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'User List'.tr(),
        isDrawerIcon: false,
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).pushNamed(Routes.addUserScreen);
          }, icon: const Icon(Icons.person_add_alt_1_sharp, color: colorGray ,))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 100, // Replace with the actual number of items you have
          itemBuilder: (context, index) {
            return ListTile(
              leading: const CircleAvatar(
                backgroundImage: NetworkImage("https://randomuser.me/api/portraits/men/5.jpg"),
                maxRadius: 20,
              ),
              title:const Text("Abc Abc",),
              subtitle: const Text("abc abc "),
              trailing: IconButton(onPressed: (){},icon: const Icon(Icons.person_off),),
            );
          },
        ),
      ),
    );
  }
}
