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
    print("save user");
    if (_formKey.currentState!.validate() /*&& addUserCubit.roles.isNotEmpty*/) {
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
    return BlocListener<AddUserCubit, BaseState>(
      bloc: addUserCubit,
      listener: (context, state) {
        if(state is AddSaveUserState){
          Navigator.pop(context,true);
        }
      },
      child: Scaffold(
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
                        ScaffoldMessenger.of(context).showSnackBar(getSnackBar(
                            state.message ?? "Added"));
                      } else if (state is ErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(getSnackBar(
                            state.errorMessage ?? "error invalid"));
                      }
                    },
                    builder: (context, state) {
                      if (state is LoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      else if (state is SaveUserState) {
                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border:
                                  Border.all(color: colorPrimary, width: 1)),
                              padding: const EdgeInsets.all(4),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment
                                    .start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  LabelTextField(
                                    controller: addUserCubit.usernameController,
                                    label: "Username",
                                    validate: (value) {
                                      if (value.isEmpty) {
                                        return 'Username is required';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  /* LabelTextField(
                                  controller: addUserCubit.clientNameController,
                                  label: "Developer/Client Name",
                                  validate: (value) {
                                    if (value.isEmpty) {
                                      // return 'Username is required';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                LabelTextField(
                                  controller: addUserCubit.uniqueNameController,
                                  label: "Unique Name",
                                  validate: (value) {
                                    if (value.isEmpty) {
                                      return 'Unique name is required';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),*/
                                  LabelTextField(
                                    controller: addUserCubit.emailController,
                                    label: "Email",
                                    validate: (value) {
                                      if (value.isEmpty) {
                                        return 'email is required';
                                      }
                                      return validateEmail(value);
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  LabelTextField(
                                    controller: addUserCubit.phoneController,
                                    label: "Phone",
                                    validate: (value) {
                                      if (value.isEmpty) {
                                        return "Phone number is required";
                                      }
                                      return validateMobileNumber(value);
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  LabelTextField(
                                    controller: addUserCubit
                                        .technologyController,
                                    label: "Technology",
                                    validate: (value) {
                                      if (value.isEmpty) {
                                        return 'Technology is required';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
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
      ),
    );
  }
}
