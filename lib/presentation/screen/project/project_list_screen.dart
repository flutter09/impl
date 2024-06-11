import 'package:chat_application/base/base_state.dart';
import 'package:chat_application/config/route/route_manager.dart';
import 'package:chat_application/config/theme/app_theme.dart';
import 'package:chat_application/presentation/screen/project/bloc/project_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_conatainer.dart' as di;
import '../../../utils/utils.dart';
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

  final projectCubit = di.di<ProjectCubit>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    projectCubit.getProjects();
  }

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  /*void _closeDrawer() {
    Navigator.of(context).pop();
  }*/

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
      body: BlocConsumer<ProjectCubit, BaseState>(
        bloc: projectCubit,
        listener: (context, state) {
          if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
                getSnackBar(state.errorMessage ?? "error invalid"));
          }
        },
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            color: AppColor.backgroundGray,
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
                          "you have total ${projectCubit.projectList.length} projects",
                          style: theme.textTheme.bodySmall,
                        )
                      ],
                    )),
                    IconButton(
                      onPressed: () async {
                        var result = await Navigator.of(context)
                            .pushNamed(Routes.createProjectRoute);
                        if(result!= null && result == true){
                          projectCubit.getProjects();
                        }
                      },
                      iconSize: 30,
                      icon: Icon(
                        Icons.add_circle_outline_sharp,
                        color: AppColor.colorGray,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: projectCubit.projectList.length,
                      itemBuilder: (context, index) {
                        var project = projectCubit.projectList[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: ListTile(
                            onTap: () {
                              /*Navigator.pushNamed(
                                  context, Routes.groupListScreen,arguments: project);*/
                            },
                            tileColor: Colors.white,
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(project.image ?? ""),
                              maxRadius: 20,
                            ),
                            title: Text(
                              project.name??'',
                              style: theme.textTheme.titleMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    // Handle edit icon pressed
                                    // Add your logic here
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.person_add),
                                  onPressed: () {
                                    // Handle add person icon pressed
                                    // Add your logic here
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
