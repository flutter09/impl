import 'package:chat_application/base/base_state.dart';
import 'package:chat_application/config/theme/app_theme.dart';
import 'package:chat_application/presentation/screen/user/bloc/add_user_cubit.dart';
import 'package:chat_application/presentation/screen/user/bloc/user_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/model/request/custom_user.dart';
import '../../../injection_conatainer.dart' as di;
import '../../../utils/utils.dart';
import '../component/custom_appbar.dart';
import '../component/custom_dropdown.dart';
import '../component/custom_textfield.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();
  final addUserCubit = di.di<AddUserCubit>();

  String? roleError;

  void addToRole(List<String> list) {
    print("add to role : $list");
    setState(() {
      addUserCubit.roles.clear();
      addUserCubit.roles.addAll(list);
      roleError = list.isEmpty ? 'role must not be empty' : null;
    });
  }

  void onSave() {
    if (_formKey.currentState!.validate() && addUserCubit.roles.isNotEmpty) {
      var customUser = CustomUser(
          name: addUserCubit.emailController.text,
          customName: addUserCubit.customNameController.text,
          roles: addUserCubit
              .roles); //todo : change email with username which is getting from search api
      // todo make api call to add user and navigate pop
      addUserCubit.addSaveUser();
    } else if (addUserCubit.roles.isEmpty) {
      setState(() {
        roleError = 'role must not be empty';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: 'Add User'.tr(),
        isDrawerIcon: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: LabelTextField(
                        label: 'Email/Phone or User Name',
                        validate: (value) {
                          return null;
                        },
                        controller: addUserCubit.emailController,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          color: colorPrimary),
                      child: IconButton(
                        onPressed: addUserCubit.searchUser,
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<AddUserCubit, BaseState>(
                  bloc: addUserCubit,
                  listener: (context, state) {
                    if (state is AddSaveUserState) {
                      ScaffoldMessenger.of(context).showSnackBar(getSnackBar(state.message ?? "Added"));
                    }else if (state is ErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(getSnackBar(state.errorMessage ?? "error invalid"));
                    }
                  },
                  builder: (context, state) {
                    if (state is LoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    else if(state is SaveUserState){
                      var saveUser = state.saveUserModel;
                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border:
                                Border.all(color: colorPrimary, width: 1)),
                            padding: const EdgeInsets.all(4),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              6),
                                          border: Border.all(
                                              color: colorPrimary, width: 1),
                                          color: colorPrimary),
                                      width: 100,
                                      height: 100,
                                      child: Center(child: Text(saveUser.name[0] , style: theme.textTheme.headlineLarge?.copyWith(color: backgroundGray ),)),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            saveUser.name,
                                            style: theme.textTheme.titleLarge,
                                          ),
                                          Text(
                                            "E-mail id: ${saveUser.email}",
                                            style: theme.textTheme.bodyMedium,
                                          ),
                                          Text(
                                            "Phone: ${saveUser.phone}",
                                            style: theme.textTheme.bodyMedium,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      LabelTextField(
                                        controller: addUserCubit.customNameController,
                                        label: "Custom name",
                                        validate: (value) {
                                          if (value.isEmpty) {
                                            return 'Text Field 1 is required';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      LabelMultipleChipDropDown(
                                        options: addUserCubit.options,
                                        label: 'Role',
                                        onSave: addToRole,
                                        errorText: roleError,
                                        selectedValues: addUserCubit.roles,
                                          isSingleSelected: false
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: onSave,
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
                                    'Add User',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ).tr(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    else {
                      return Container();
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
