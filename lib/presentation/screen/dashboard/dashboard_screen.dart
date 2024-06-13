import 'dart:ffi';

import 'package:chat_application/base/base_state.dart';
import 'package:chat_application/base/extension/context_extension.dart';
import 'package:chat_application/config/theme/app_theme.dart';
import 'package:chat_application/injection_conatainer.dart';
import 'package:chat_application/presentation/screen/component/loading_screen.dart';
import 'package:chat_application/presentation/screen/component/product_card.dart';
import 'package:chat_application/presentation/screen/dashboard/bloc/dashboard_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

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
  }

  final List<Map<String, dynamic>> gridData = [
    {"title": "Item 1", "description": "2"},
    {"title": "Item 2", "description": "2"},
    {"title": "Item 3", "description": "3"},
    {"title": "Item 4", "description": "4"},
  ];

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
                  itemCount: gridData.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                    mainAxisExtent: 80
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return DashboardCard(
                      title: gridData[index]['title'],
                      description: gridData[index]['description'],
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
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView.builder(
                        itemCount: 10, // Number of items in the list
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: ProductCard(),
                          );
                        },
                      ),
                      // Second tab content
                      ListView.builder(
                        itemCount: 5, // Number of items in the list
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text('Item ${index + 1}'),
                            subtitle: Text('This is description for Item ${index + 1}'),
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
