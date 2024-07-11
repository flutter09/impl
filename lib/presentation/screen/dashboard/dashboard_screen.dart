import 'package:chat_application/base/base_state.dart';
import 'package:chat_application/config/route/route_manager.dart';
import 'package:chat_application/config/theme/app_theme.dart';
import 'package:chat_application/injection_conatainer.dart';
import 'package:chat_application/presentation/screen/component/loading_screen.dart';
import 'package:chat_application/presentation/screen/component/product_card.dart';
import 'package:chat_application/presentation/screen/dashboard/bloc/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../utils/utils.dart';
import '../component/dashboard_card.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> with SingleTickerProviderStateMixin {
  DashboardCubit dashboardCubit = di<DashboardCubit>();
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this,);
    dashboardCubit.getProject();
    dashboardCubit.getOtherProject();
    dashboardCubit.getFavouriteProject();
    dashboardCubit.getOtherFavouriteProject();
    dashboardCubit.getSaveUserList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardCubit, BaseState>(
      bloc: dashboardCubit,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return LoadingScreen(
          isLoading: state is LoadingState,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                /*Text(
                  "Dashboard".tr(),
                  style: context.themeData.textTheme.headlineLarge,
                ),*/
                const Gap(8),
                GridView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dashboardCubit.gridData.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                    mainAxisExtent: 80
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return DashboardCard(
                      title: dashboardCubit.gridData[index]['title'] ?? '',
                      description: dashboardCubit.gridData[index]['description'] ?? '',
                    );
                  },
                ),
                const Gap(8),
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
                    Tab(text: 'My favourite'),
                    Tab(text: 'Other favourite'),
                  ],
                ),
                const Gap(4),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView.builder(
                        itemCount: dashboardCubit.favouriteProject.length, // Number of items in the list
                        itemBuilder: (BuildContext context, int index) {
                          var project = dashboardCubit.favouriteProject[index];
                          return ProductCard(
                            onClick: (){
                              Navigator.pushNamed(context, Routes.projectDetailScreen, arguments: project.sId);
                            },
                            title: project.name ?? '',
                            description:
                            'Updated at ${dateToFormat(project.updatedAt ?? '', format: 'dd MMM')}',
                            groupNames: project.groupDetails?.map((e) => getTwoCharString(e.name ?? '')).toList(),
                          );
                        },
                      ),
                      // Second tab content
                      ListView.builder(
                        itemCount: dashboardCubit.favouriteOtherProject.length, // Number of items in the list
                        itemBuilder: (BuildContext context, int index) {
                          var project = dashboardCubit.favouriteOtherProject[index];
                          return ProductCard(
                            onClick: (){
                              Navigator.pushNamed(context, Routes.projectDetailScreen, arguments: project.sId);
                            },
                            title: project.name ?? '',
                            description:
                            'Updated at ${dateToFormat(project.updatedAt ?? '', format: 'dd MMM')}',
                            groupNames: project.groupDetails?.map((e) => getTwoCharString(e.name ?? '')).toList(),
                          );
                        },
                      ),
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
