import 'package:chat_application/base/base_state.dart';
import 'package:chat_application/config/route/route_manager.dart';
import 'package:chat_application/config/theme/app_theme.dart';
import 'package:chat_application/presentation/screen/component/loading_screen.dart';
import 'package:chat_application/presentation/screen/project/bloc/project_detail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../injection_conatainer.dart';
import '../../../utils/utils.dart';
import '../component/group_card.dart';
import '../component/main_parent_screen.dart';
import '../component/product_card.dart';

class ProjectDetailScreen extends StatefulWidget {
  const ProjectDetailScreen({super.key});

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> with SingleTickerProviderStateMixin{
  final projectDetailCubit = di<ProjectDetailCubit>();
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this,);
    projectDetailCubit.getProjectDetails();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocConsumer<ProjectDetailCubit, BaseState>(
      bloc: projectDetailCubit,
      listener: (context, state) {
        if (state is ErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(getSnackBar(state.errorMessage ?? "error invalid"));
        }
      },
      builder: (context, state) {
        return LoadingScreen(
          isLoading: state is LoadingState,
          child: MainParentScreen(
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
                                projectDetailCubit.project?.name ?? '',
                                style: theme.textTheme.headlineLarge,
                              ),
                              Text(
                                projectDetailCubit.project?.description ?? '',
                                style: theme.textTheme.bodySmall,
                              )
                            ],
                          ),),
                      IconButton(
                        onPressed: () async {
                          var result = await Navigator.of(context)
                              .pushNamed(Routes.createProjectRoute);
                          if (result != null && result == true) {
                            projectDetailCubit.editProject();
                          }
                        },
                        iconSize: 30,
                        icon: Icon(
                          Icons.edit_note_outlined,
                          color: AppColor.colorGray,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          var result = await Navigator.of(context)
                              .pushNamed(Routes.createProjectRoute);
                          if (result != null && result == true) {
                            projectDetailCubit.deleteProject();
                          }
                        },
                        iconSize: 30,
                        icon: Icon(
                          Icons.delete_outline_outlined,
                          color: AppColor.notifyRed,
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
                      Tab(text: 'Groups'),
                      Tab(text: 'Members'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        ListView.builder(
                            itemCount: projectDetailCubit.project?.groupDetails?.length,
                            itemBuilder: (context, index) {
                              var group = projectDetailCubit.project?.groupDetails?[index];
                              return GroupCard(
                                title: group?.name ?? '',
                                groupNames: group?.groupMembers?.map((e) => getTwoCharString(e.userName ?? '')).toList(),
                              );
                            }),
                        ListView.builder(
                            itemCount: projectDetailCubit.project?.projectMembers?.length,
                            itemBuilder: (context, index) {
                              var member = projectDetailCubit.project?.projectMembers?[index];
                              return ProductCard(
                                title: member?.userName ?? '',
                              );
                            }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
