import 'package:chat_application/base/base_state.dart';
import 'package:chat_application/base/extension/context_extension.dart';
import 'package:chat_application/config/route/route_manager.dart';
import 'package:chat_application/domain/model/response/res_project.dart';
import 'package:chat_application/domain/model/response/save_user_model.dart';
import 'package:chat_application/presentation/screen/project/bloc/project_cubit.dart';
import 'package:chat_application/presentation/screen/project/bloc/project_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/theme/app_theme.dart';
import '../../../injection_conatainer.dart' as di;
import '../../../utils/utils.dart';
import '../component/component.dart';
import '../component/custom_appbar.dart';
import '../component/custom_drawer.dart';
import '../component/custom_dropdown.dart';
import '../component/custom_textfield.dart';

class CreateProjectScreen extends StatefulWidget {
  bool isUpdateProject;
  String? projectId;
  CreateProjectScreen({super.key , this.isUpdateProject = false, this.projectId,});

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final projectCubit = di.di<ProjectCubit>();

  @override
  void initState() {
    super.initState();
    projectCubit.getSaveUserList();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: 'Add Project'.tr(),
        isDrawerIcon: false,
        /*onLeadPress: () => _openDrawer(),*/
        actions: <Widget>[
          AppBarAction(icon: Icons.settings, onPress: () {}),
          const SizedBox(
            width: 20,
          ),
          AppBarAction(icon: Icons.edit, onPress: () {}),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: BlocConsumer<ProjectCubit, BaseState>(
        bloc: projectCubit,
        listener: (context, state) {
          if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
                getSnackBar(state.errorMessage ?? "error invalid"));
          }else if (state is RegisterProjectState) {
            context.showSnackBar(message: state.msg ?? '');
            Navigator.pop(context,true);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              if(state is LoadingState) const Center(child: CircularProgressIndicator()),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        LabelTextField(
                          label: 'Title',
                          hintText: 'Enter Title'.tr(),
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Name must not be Empty !!';
                            }
                            return null;
                          },
                          controller: projectCubit.projectNameController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        /*LabelDatePickerTextField(
                      controller: startDateController,
                      label: "Start Date",
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Start date must not be Empty !!';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        if (_formKey.currentState!.validate()) {}
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    LabelDatePickerTextField(
                      controller: endDateController,
                      label: "End Date",
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'End date must not be Empty !!';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        if (_formKey.currentState!.validate()) {}
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),*/
                        LabelTextField(
                          controller: projectCubit.projectDescController,
                          label: "Description",
                          hintText: 'Your Description'.tr(),
                          maxLine: 4,
                          contentPadding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        ),
                        const SizedBox(height: 20),
                        /*LabelTextField(
                      controller: projectDescController,
                      label: "Budget",
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'End date must not be Empty !!';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        if (_formKey.currentState!.validate()) {}
                      },
                    ),
                    const SizedBox(height: 20),
                    LabelDropDown(
                      label: 'Priority Status',
                      options: options,
                    ),
                    const SizedBox(height: 20),
                    LabelDropDown(
                      label: 'Category',
                      options: options,
                    ),
                    const SizedBox(height: 20),*/
                    /*LabelMultipleChipDropDown(
                      options: options,
                      label: 'Members',
                      isSingleSelected: true,
                    ),*/
                    /*const SizedBox(height: 20),
                    LabelTextField(
                      label: 'Image',
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Name must not be Empty !!';
                        }
                        return null;
                      },
                      hintText: "choose file".tr(),
                      onTap: () async {
                        File? file = await pickImageFromGallery(context);
                        imageController.text = file?.path ?? "No file chosen";
                      },
                      controller: imageController,
                      readOnly: true,
                    ),
                    const SizedBox(height: 20),*/
                        //todo member selection
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Members",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.colorGray),
                              ).tr(),
                            ),
                            GestureDetector(
                              onTap: addMemberDialog,
                              child: Text(
                                "+ Add Member",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.colorPrimary),
                              ).tr(),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        projectCubit.projectMemberList.isEmpty
                            ? Container(
                          alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Text('No user selected for this project'))
                            : ListView.separated(
                            itemCount: projectCubit.projectMemberList.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder: (context, index) =>
                            const Divider(
                              height: 1,
                              color: Colors.grey,
                            ),
                            itemBuilder: (context, index) {
                              var user = projectCubit.projectMemberList[index];
                              return ListTile(

                                title: Text(
                                  '${user.chatName ?? ''} - ${user.role ?? ''}',
                                  style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  user.userName??'',
                                  style: theme.textTheme.bodySmall,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                  ),
                                  onPressed: () {
                                    deleteUser(user);
                                  },
                                ),
                              );
                            }),
                        /*Container(
                          height: 300,
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(
                                5)),
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          child: projectCubit.selectedMembers.isEmpty
                              ? const Center(
                              child: Text('No user selected for this project'))
                              : ListView.separated(
                              itemCount: projectCubit.selectedMembers.length,
                              separatorBuilder: (context, index) =>
                              const Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                              itemBuilder: (context, index) {
                                var user = projectCubit.selectedMembers[index];
                                return ListTile(
                                  title: Text(
                                    user.userName??'',
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                  subtitle: Text(
                                    user.role??'',
                                    style: theme.textTheme.bodySmall,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                    ),
                                    onPressed: () {
                                      deleteUser(user);
                                    },
                                  ),
                                );
                              }),
                        ),*/
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar:
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: projectCubit.registerProject,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.add,
                color: Colors.white,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'Create Project',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ).tr(),
            ],
          ),
        ),
      ),
    );
  }


  void addMemberDialog() async {
    List<SaveUser> projectMember = projectCubit.saveUserList.where((user) => !projectCubit.projectMemberList.any((member) => member.userName == user.firstName)).toList();
    String? selectedRole;
    String? userName;
    TextEditingController chatNameController = TextEditingController();
    var memberFormKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          insetPadding: EdgeInsets.all(10),
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: memberFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Add Member',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    LabelDropDown(
                      selectedOption: userName,
                      options: projectMember.map((e) => e.firstName).nonNulls.toList(),
                      label: 'User name',
                      onChanged: (value){
                        setState(() {
                          userName = value;
                          chatNameController.text = value ?? '';
                        });
                      },
                      validate: (value) {
                        return validateRequireField(value);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    LabelTextField(
                      controller: chatNameController,
                      label: "Display name",
                      validate: (value) {
                        return validateRequireField(value);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    LabelDropDown(
                      selectedOption: selectedRole,
                      options: Role.values.map((e) => e.name).toList(),
                      label: 'Role',
                      onChanged: (value){
                        setState(() {
                          selectedRole = value;
                        });
                      },
                      validate: (value) {
                        return validateRequireField(value);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        defaultTextButton(
                            function: (){
                              if(memberFormKey.currentState?.validate() ?? false) {
                                projectCubit.addProjectMember(
                                    saveUser: projectMember.firstWhere((e) => e
                                        .firstName == userName),
                                    chatName: chatNameController.text,
                                    role: selectedRole);
                                Navigator.pop(context);
                              }
                            },
                            text: "Save",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: AppColor.colorPrimary)),
                        const SizedBox(
                          width: 10,
                        ),
                        defaultTextButton(
                            function: () {
                              Navigator.pop(context);
                            },
                            text: "Cancel",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: AppColor.colorGray)),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void deleteUser(ProjectMember resProjectMember) {
    projectCubit.removeUser(resProjectMember);
    setState(() {});
  }
}
