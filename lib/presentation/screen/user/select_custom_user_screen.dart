import 'package:chat_application/base/base_state.dart';
import 'package:chat_application/presentation/screen/user/bloc/select_custom_user_cubit.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/theme/app_theme.dart';
import '../../../domain/model/response/res_project.dart';
import '../../../injection_conatainer.dart' as di;
import '../../../utils/utils.dart';
import '../component/custom_appbar.dart';
import '../component/custom_user_addition_card.dart';

class SelectUserScreen extends StatefulWidget {
  final List<ProjectMember>? selectedContact;

  const SelectUserScreen({super.key, this.selectedContact});

  @override
  State<SelectUserScreen> createState() => _SelectUserScreenState();
}

class _SelectUserScreenState extends State<SelectUserScreen> {
  final selectCustomUserCubit = di.di<SelectCustomUserCubit>();
  final List<String> role = ["Project Manager","Team Lead","Developer"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectCustomUserCubit.initSelectList(widget.selectedContact ?? []);
    selectCustomUserCubit.getSaveUserList();
  }

  @override
  Widget build(BuildContext context) {
    // final TextEditingController groupNameController = TextEditingController();

    void onCompleteSelection() {
      Navigator.pop(context, selectCustomUserCubit.selectedMembers);
    }

    return Scaffold(
      appBar: CustomAppBar(
        isDrawerIcon: false,
        onLeadPress: () {
          Navigator.pop(context);
        },
        title: 'Select User',
      ),
      body: BlocConsumer<SelectCustomUserCubit, BaseState>(
        bloc: selectCustomUserCubit,
        listener: (context, state) {
          if (state is RefreshState) {
            setState(() {
            });
          }else if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(getSnackBar(state.errorMessage ?? "error invalid"));
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      color: AppColor.backgroundGray,
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.builder(
                          itemCount: selectCustomUserCubit.saveUserList.length,
                          itemBuilder: (context, index) {
                            ProjectMember? user = selectCustomUserCubit.selectedMembers.firstWhereOrNull(
                                    (element) => element.userId == selectCustomUserCubit.saveUserList[index].sId);
                            return CustomUserAdditionCard(
                              contact: selectCustomUserCubit.saveUserList[index].firstName ?? "",
                              options: /*selectCustomUserCubit.saveUserList[index].roles?.map((e) => e.toString()).toList() ?? []*/role,
                              isSelected: user != null,
                              customName: user?.userName,
                              roles: user?.role != null ? [user?.role ?? ''] : [],
                              onSave: (customName , roles){
                                selectCustomUserCubit.addUser(selectCustomUserCubit.saveUserList[index] , customName , roles);
                                setState(() {

                                });
                              },
                              isSingleRole: true,
                            );
                          }),
                    ),
                  ),
                ],
              ),
              if(state is LoadingState) const Center(child: CircularProgressIndicator()),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onCompleteSelection,
        backgroundColor: AppColor.colorPrimary,
        child: const Icon(
          Icons.done,
          color: Colors.white,
        ),
      ),
    );
  }
}
