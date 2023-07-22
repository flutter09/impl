import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_application/config/route/route_manager.dart';
import 'package:chat_application/config/theme/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../component/component.dart';
import '../component/custom_appbar.dart';
import '../component/custom_drawer.dart';

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({super.key});

  @override
  State<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
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
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(
              backgroundImage:
                  NetworkImage("https://randomuser.me/api/portraits/men/5.jpg"),
              maxRadius: 20,
            ),
          )
        ],
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
                      "Projects".tr(),
                      style: theme.textTheme.headlineLarge,
                    ),
                    Text(
                      "you have total 19 projects",
                      style: theme.textTheme.bodySmall,
                    )
                  ],
                )),
                defaultTextButton(
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, color: colorPrimary),
                  function: () {
                    Navigator.of(context).pushNamed(Routes.createProjectRoute);
                  },
                  text: 'Add Project',
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: ListTile(
                        onTap: (){
                          Navigator.pushNamed(context, Routes.groupListScreen);
                        },
                        tileColor: Colors.white,
                        leading: const CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://randomuser.me/api/portraits/men/5.jpg"),
                          maxRadius: 20,
                        ),
                        title: Text(
                          "Web Development $index",
                          style: theme.textTheme.titleMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.menu)),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
