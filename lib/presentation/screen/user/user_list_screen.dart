import 'package:chat_application/config/route/route_manager.dart';
import 'package:chat_application/presentation/screen/user/bloc/save_user_list_cubit.dart';
import 'package:chat_application/presentation/screen/user/save_user_editing_dailog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../base/base_state.dart';
import '../../../config/theme/app_theme.dart';
import '../../../injection_conatainer.dart' as di;
import '../../../utils/utils.dart';
import '../component/custom_appbar.dart';
import '../component/custom_drawer.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final SaveUserListCubit saveUserListCubit = di.di<SaveUserListCubit>();

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
    saveUserListCubit.getSaveUserList();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        isDrawerIcon: true,
        onLeadPress: () => _openDrawer(),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.of(context).pushNamed(Routes.addUserScreen);
            },
            icon: Icon(
              Icons.notifications_active,
              color: AppColor.colorGray,
            ),
          ),
          const Padding(
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
      body: BlocConsumer<SaveUserListCubit, BaseState>(
        bloc: saveUserListCubit,
        listener: (context, state) {
          if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
                getSnackBar(state.errorMessage ?? "error invalid"));
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
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
                              "Members".tr(),
                              style: theme.textTheme.headlineLarge,
                            ),
                            Text(
                              "you have total ${saveUserListCubit.saveUserList.length} members",
                              style: theme.textTheme.bodySmall,
                            )
                          ],
                        )),
                        IconButton(
                          onPressed: () async {
                            var result = await Navigator.of(context)
                                .pushNamed(Routes.addUserScreen);
                            if (result != null && result == true) {
                              saveUserListCubit.getSaveUserList();
                            }
                          },
                          icon: Icon(
                            Icons.person_add_alt_1_sharp,
                            color: AppColor.colorGray,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: saveUserListCubit.saveUserList.length,
                          itemBuilder: (context, index) {
                            var project = saveUserListCubit.saveUserList[index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: ListTile(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.groupListScreen,
                                      arguments: project);
                                },
                                tileColor: Colors.white,
                                leading: Container(
                                  width: 40.0,
                                  height: 40.0,
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.colorPurple,
                                  ),
                                  child: FittedBox(
                                    child: Text(
                                      project.firstName?[0].toUpperCase() ?? "",
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.8),
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  project.firstName ?? '',
                                  style: theme.textTheme.titleMedium,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  project.email ?? '',
                                  style: theme.textTheme.bodySmall,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return SaveUserEditingDialog(
                                                userSaveData: project);
                                          },
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.person_off),
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
              ),
              if (state is LoadingState)
                const Center(child: CircularProgressIndicator()),
            ],
          );
        },
      ),
    );
  }
}
