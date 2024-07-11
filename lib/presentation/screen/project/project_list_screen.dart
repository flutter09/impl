import 'package:chat_application/base/base_state.dart';
import 'package:chat_application/config/route/route_manager.dart';
import 'package:chat_application/config/theme/app_theme.dart';
import 'package:chat_application/presentation/screen/component/loading_screen.dart';
import 'package:chat_application/presentation/screen/project/bloc/project_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../injection_conatainer.dart' as di;
import '../../../utils/utils.dart';
import '../component/product_card.dart';

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({super.key});

  @override
  State<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> with SingleTickerProviderStateMixin {
  final projectCubit = di.di<ProjectCubit>();
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this,);
    projectCubit.getProjects();
    projectCubit.getOtherProject();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocConsumer<ProjectCubit, BaseState>(
      bloc: projectCubit,
      listener: (context, state) {
        if (state is ErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(getSnackBar(state.errorMessage ?? "error invalid"));
        }
      },
      builder: (context, state) {
        return LoadingScreen(
          isLoading: state is LoadingState,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
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
                          "you have total ${projectCubit.projectList.length + projectCubit.otherProjectList.length} projects",
                          style: theme.textTheme.bodySmall,
                        )
                      ],
                    )),
                    IconButton(
                      onPressed: () async {
                        var result = await Navigator.of(context)
                            .pushNamed(Routes.createProjectRoute);
                        if (result != null && result == true) {
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
                const Gap(10),
                TabBar(
                  overlayColor: WidgetStatePropertyAll(AppColor.colorPurple.withOpacity(0.1)),
                  splashBorderRadius: BorderRadius.circular(30),
                  indicatorColor: AppColor.colorPurple,
                  labelColor: AppColor.colorPurple,
                  unselectedLabelColor: Colors.black,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16
                  ),
                  unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'My Project'),
                    Tab(text: 'Other Project'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView.builder(
                          itemCount: projectCubit.projectList.length,
                          itemBuilder: (context, index) {
                            var project = projectCubit.projectList[index];
                            return ProductCard(
                              onClick: (){
                                Navigator.pushNamed(context, Routes.projectDetailScreen, arguments: project.sId);
                              },
                              title: project.name ?? '',
                              description:
                              'Updated at ${dateToFormat(project.updatedAt ?? '', format: 'dd MMM')}',
                              groupNames: project.groupDetails?.map((e) => getTwoCharString(e.name ?? '')).toList(),
                            );
                          }),
                      ListView.builder(
                          itemCount: projectCubit.otherProjectList.length,
                          itemBuilder: (context, index) {
                            var project = projectCubit.otherProjectList[index];
                            return ProductCard(
                              onClick: (){
                                Navigator.pushNamed(context, Routes.projectDetailScreen, arguments: project.sId);
                              },
                              title: project.name ?? '',
                              description:
                              'Updated at ${dateToFormat(project.updatedAt ?? '', format: 'dd MMM')}',
                              groupNames: project.groupDetails?.map((e) => getTwoCharString(e.name ?? '')).toList(),
                            );
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
