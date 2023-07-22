import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../config/theme/app_theme.dart';
import '../component/custom_appbar.dart';
import '../component/custom_drawer.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: 'IMPM',
        isDrawerIcon: true,
        onLeadPress: () => _openDrawer(),
      ),
      drawer: const CustomDrawer(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8,),
            Text('Personal Information'.tr() , style: theme.textTheme.headlineMedium,),
            ListTile(
              title: Text("Full Name" , style: theme.textTheme.bodyLarge,),
              subtitle: Text("Abc abc" , style: theme.textTheme.titleSmall,maxLines: 1,overflow: TextOverflow.ellipsis,),
            ),
            ListTile(
              title: Text("Display Name" , style: theme.textTheme.bodyLarge,),
              subtitle: Text("Abc abc" , style: theme.textTheme.titleSmall,maxLines: 1,overflow: TextOverflow.ellipsis,),
            ),
            ListTile(
              title: Text("E-mail" , style: theme.textTheme.bodyLarge,),
              subtitle: Text("Abcabc@abc.com" , style: theme.textTheme.titleSmall,maxLines: 1,overflow: TextOverflow.ellipsis,),
            ),
            ListTile(
              title: Text("Phone Number" , style: theme.textTheme.bodyLarge,),
              subtitle: Text("+91 95959 95959" , style: theme.textTheme.titleSmall,maxLines: 1,overflow: TextOverflow.ellipsis,),
            ),
            ListTile(
              title: Text("Date of Birth" , style: theme.textTheme.bodyLarge,),
              subtitle: Text("27 June 2023" , style: theme.textTheme.titleSmall,maxLines: 1,overflow: TextOverflow.ellipsis,),
            ),
            ListTile(
              title: Text("Address" , style: theme.textTheme.bodyLarge,),
              subtitle: Text("Abc abcAbc abcAbc abcAbc abcAbc abcAbc abcAbc abcAbc abcAbc abcAbc abcAbc abcAbc abcAbc abcAbc abcAbc abcAbc abcAbc abc" , style: theme.textTheme.titleSmall,maxLines: 3,overflow: TextOverflow.ellipsis,),
            )
          ],
        ),
      ),
    );
  }
}
