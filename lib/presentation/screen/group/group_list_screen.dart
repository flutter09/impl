import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../config/route/route_manager.dart';
import '../../../config/theme/app_theme.dart';
import '../component/component.dart';
import '../component/custom_appbar.dart';
import '../component/custom_drawer.dart';
import '../component/group_card.dart';

class GroupListScreen extends StatefulWidget {
  const GroupListScreen({super.key});

  @override
  State<GroupListScreen> createState() => _GroupListScreenState();
}

class _GroupListScreenState extends State<GroupListScreen> {
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
        color: backgroundGray,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Groups".tr(),
                      style: theme.textTheme.headlineLarge,
                    ),
                    Text(
                      "you have total 19 groups in this project".tr(),
                      style: theme.textTheme.bodySmall,
                    )
                  ],
                )),
                defaultTextButton(
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, color: colorPrimary),
                  function: () {
                    Navigator.of(context)
                        .pushNamed(Routes.createGroupNewScreen);
                  },
                  text: 'Add Group',
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return CustomCardWidget(
                      title: 'Card Title',
                      description:
                          'This is a one-liner description of the project.',
                      longDescription:
                          'This is a one-liner description of the project.',
                      progressPercentage: 75,
                      logoImageUrl:
                          "https://randomuser.me/api/portraits/men/5.jpg",
                      groupImageUrls: const [
                        "https://randomuser.me/api/portraits/men/5.jpg",
                        "https://randomuser.me/api/portraits/men/5.jpg",
                        "https://randomuser.me/api/portraits/men/5.jpg",
                        "https://randomuser.me/api/portraits/men/5.jpg",
                        "https://randomuser.me/api/portraits/men/5.jpg",
                        "https://randomuser.me/api/portraits/men/5.jpg",
                        "https://randomuser.me/api/portraits/men/5.jpg",
                        "https://randomuser.me/api/portraits/men/5.jpg"
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
