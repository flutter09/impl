import 'dart:io';

import 'package:chat_application/presentation/screen/group/bloc/group_state.dart';
import 'package:chat_application/presentation/screen/project/bloc/project_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../base/base_state.dart';
import '../../../domain/model/response/res_project.dart';
import '../../../injection_conatainer.dart' as di;
import '../../../utils/utils.dart';
import '../component/custom_appbar.dart';
import '../component/custom_drawer.dart';
import '../component/custom_textfield.dart';
import 'bloc/group_cubit.dart';

class CreateGroupNewScreen extends StatefulWidget {
  final ResProject? currentProject;
  const CreateGroupNewScreen({super.key, this.currentProject});

  @override
  State<CreateGroupNewScreen> createState() => _CreateGroupNewScreenState();
}

class _CreateGroupNewScreenState extends State<CreateGroupNewScreen> {
  final groupNameController = TextEditingController();
  final groupDescController = TextEditingController();
  final imageController = TextEditingController();
  File? file;

  final groupCubit = di.di<GroupCubit>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  /*void _closeDrawer() {
    Navigator.of(context).pop();
  }*/

  @override
  Widget build(BuildContext context) {
    /*var theme = Theme.of(context);
    final List<String> options = [
      'Option 1',
      'Option 2',
      'Option 3',
      'Option 4',
      'Option 5',
    ];*/
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: 'Create Group'.tr(),
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
      body: BlocConsumer<GroupCubit, BaseState>(
        listener: (context, state) {
          if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
                getSnackBar(state.errorMessage ?? "error invalid"));
          }else if(state is RegisterGroupState){
            ScaffoldMessenger.of(context).showSnackBar(
                getSnackBar(state.msg ?? "Group Registered successfully"));
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Visibility(visible: state is LoadingState , child: const Center(child: CircularProgressIndicator()),),
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
                          label: 'Group Name',
                          hintText: 'Enter Title'.tr(),
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Name must not be Empty !!';
                            }
                            return null;
                          },
                          controller: groupNameController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        LabelTextField(
                          controller: groupDescController,
                          label: "Group Description",
                          hintText: 'Your Description'.tr(),
                          maxLine: 5,
                          contentPadding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        ),
                        const SizedBox(height: 20),
                        LabelTextField(
                          label: 'Image',
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Image must not be Empty !!';
                            }
                            return null;
                          },
                          hintText: "choose file".tr(),
                          onTap: () async {
                            file = await pickImageFromGallery(context);
                            imageController.text =
                                file?.path
                                    .split('/')
                                    .last ?? "No file chosen";
                          },
                          controller: imageController,
                          readOnly: true,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // groupCubit.registerGroup()
                            },
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
                                  'Create Group',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ).tr(),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
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
    );
  }
}
