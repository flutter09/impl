import 'package:chat_application/base/base_state.dart';
import 'package:chat_application/domain/model/response/res_project.dart';
import 'package:chat_application/presentation/screen/group/bloc/group_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/route/route_manager.dart';
import '../../../config/theme/app_theme.dart';
import '../../../injection_conatainer.dart' as di;
import '../../../utils/utils.dart';
import '../component/component.dart';
import '../component/custom_appbar.dart';
import '../component/group_card.dart';

class GroupListScreen extends StatefulWidget {
  final Project? currentProject;
  const GroupListScreen({super.key, this.currentProject});

  @override
  State<GroupListScreen> createState() => _GroupListScreenState();
}

class _GroupListScreenState extends State<GroupListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var groupCubit = di.di<GroupCubit>();

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    groupCubit.getGroups();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: const CustomAppBar(
        title: 'IMPM',
        isDrawerIcon: false,
      ),
      body: BlocConsumer<GroupCubit, BaseState>(
        bloc: groupCubit,
        listener: (context, state) {
          if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
                getSnackBar(state.errorMessage ?? "error invalid"));
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Visibility(visible: state is LoadingState , child: const Center(child: CircularProgressIndicator()),),
              Container(
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
                                  "Groups".tr(),
                                  style: theme.textTheme.headlineLarge,
                                ),
                                Text(
                                  "you have total ${groupCubit.groupList.length} groups in this project".tr(),
                                  style: theme.textTheme.bodySmall,
                                )
                              ],
                            )),
                        defaultTextButton(
                          style: TextStyle(
                              fontWeight: FontWeight.w400, color: AppColor.colorPrimary),
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
                          itemCount: groupCubit.groupList.length,
                          itemBuilder: (context, index) {
                            var group = groupCubit.groupList[index];
                            return CustomCardWidget(
                              title: group.name??'',
                              description: group.uniqueId.toString(),
                              longDescription:
                              'create at ${group.createdAt}',
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
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.chatDetailsRoute);
                              },
                            );
                          }),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
